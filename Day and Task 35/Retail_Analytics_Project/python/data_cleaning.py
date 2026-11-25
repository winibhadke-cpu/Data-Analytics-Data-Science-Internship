"""Day 23 reusable retail data cleaning. Run: python clean_data.py"""
from pathlib import Path
import pandas as pd

CANONICAL_CATEGORIES = {"electronics":"Electronics", "electronic":"Electronics", "clothing":"Clothing", "grocery":"Grocery", "groceries":"Grocery", "home":"Home"}

def clean_retail_data(df: pd.DataFrame, as_of_date=None):
    """Return (clean dataframe, audit dict). Never modify caller's dataframe."""
    required = ["Order_ID","Order_Date","Customer_Name","City","Category","Product","Quantity","Unit_Price","Sales","Customer_Rating"]
    absent = [c for c in required if c not in df.columns]
    if absent:
        raise ValueError(f"Missing required columns: {absent}")
    data=df.copy()
    audit={"rows_before":len(data),"exact_duplicates":int(data.duplicated().sum()),"missing_ratings_before":int(data.Customer_Rating.isna().sum())}
    data=data.drop_duplicates().copy()
    for c in ["Order_ID","Customer_Name","City","Category","Product"]:
        data[c]=data[c].astype('string').str.strip()
    before_categories=data['Category'].copy()
    normalized=data['Category'].str.lower()
    data['Category']=normalized.map(CANONICAL_CATEGORIES).fillna(data['Category'])
    audit['category_values_standardized']=int((before_categories != data['Category']).fillna(False).sum())
    data['Order_Date']=pd.to_datetime(data['Order_Date'],errors='coerce')
    for c in ['Quantity','Unit_Price','Sales','Customer_Rating']:
        data[c]=pd.to_numeric(data[c],errors='coerce')
    today=pd.Timestamp(as_of_date or pd.Timestamp.today().date())
    audit['invalid_dates']=int(data['Order_Date'].isna().sum())
    audit['future_dates']=int((data['Order_Date']>today).sum())
    audit['duplicate_order_ids']=int(data['Order_ID'].duplicated().sum())
    audit['negative_sales']=int((data['Sales']<0).sum())
    audit['nonpositive_quantities']=int((data['Quantity']<=0).sum())
    audit['negative_unit_prices']=int((data['Unit_Price']<0).sum())
    mismatch=(data['Sales']-(data['Quantity']*data['Unit_Price'])).abs()>0.01
    audit['sales_formula_mismatches']=int(mismatch.sum())
    critical=['Order_ID','Order_Date','Customer_Name','City','Category','Product','Quantity','Unit_Price','Sales']
    audit['critical_missing_rows']=int(data[critical].isna().any(axis=1).sum())
    if any(audit[k] for k in ['invalid_dates','future_dates','duplicate_order_ids','negative_sales','nonpositive_quantities','negative_unit_prices','sales_formula_mismatches','critical_missing_rows']):
        raise ValueError(f"Manual review required for invalid business records: {audit}")
    valid_ratings=data['Customer_Rating'].dropna()
    if not valid_ratings.between(1,5).all():
        raise ValueError('Ratings outside the allowed 1–5 range require review')
    median=float(valid_ratings.median()) if len(valid_ratings) else None
    if median is None: raise ValueError('No observed ratings available for imputation')
    data['Customer_Rating_Was_Imputed']=data['Customer_Rating'].isna()
    data['Customer_Rating']=data['Customer_Rating'].fillna(median)
    audit.update(rows_after=len(data),rating_imputation_median=median,ratings_imputed=int(data['Customer_Rating_Was_Imputed'].sum()),missing_ratings_after=int(data['Customer_Rating'].isna().sum()))
    data['Order_Date']=data['Order_Date'].dt.strftime('%Y-%m-%d')
    return data, audit

if __name__ == '__main__':
    folder=Path(__file__).resolve().parent
    clean,audit=clean_retail_data(pd.read_csv(folder/'retail_sales.csv'),as_of_date='2026-11-23')
    clean.to_csv(folder/'cleaned_retail_sales.csv',index=False)
    pd.DataFrame([{'Check':k,'Value':v} for k,v in audit.items()]).to_csv(folder/'cleaning_audit.csv',index=False)
    print('Cleaning complete:',audit)

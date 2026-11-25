from pathlib import Path
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
display=print
root=Path('../Customer_Churn_Prediction')
raw=root/'data/raw/customer_churn.csv'
assert raw.exists(), 'Add original customer_churn.csv to Customer_Churn_Prediction/data/raw first'
df=pd.read_csv(raw,dtype={'CustomerID':'string'})
audit=pd.DataFrame({'Column':df.columns,'Missing Values':df.isna().sum().values,'Missing %':df.isna().mean().values*100,'Proposed Action':'Preserve feature missingness for EDA; fit imputation on training only'})
original=len(df); duplicates=int(df.duplicated().sum()); print('Exact duplicate rows',duplicates,'Repeated IDs',df.CustomerID.duplicated().sum())
assert not df.CustomerID.isna().any(), 'Investigate missing identifiers'
assert not df.CustomerID.duplicated().any(), 'Investigate repeated IDs and grain before removing records'
for c in df.select_dtypes(include=['object','string']).columns:
    if c!='CustomerID': df[c]=df[c].astype('string').str.strip()
for c in ['MonthlyCharges','TotalCharges','TenureMonths','AvgMonthlyDataUsageGB','DaysSinceLastContact','SupportCallsLast90Days','SatisfactionScore']:
    if c in df:
        before=df[c].isna().sum(); df[c]=pd.to_numeric(df[c],errors='coerce'); print(c,'new missing',df[c].isna().sum()-before)
        if c!='SatisfactionScore':
            print(c,'negative values',int((df[c]<0).sum())); assert not (df[c]<0).any(), 'Investigate invalid negatives'
if 'ContractType' in df: df['ContractType']=df.ContractType.str.lower()
labels=df.Churn.astype('string').str.lower().map({'yes':'Yes','no':'No','1':'Yes','0':'No'})
print('Unknown target rows excluded:',labels.isna().sum()); df=df.loc[labels.notna()].copy(); df['Churn']=labels.dropna()
num=df.select_dtypes('number'); q1=num.quantile(.25); q3=num.quantile(.75); iqr=q3-q1
out=pd.DataFrame({'min':num.min(),'max':num.max(),'IQR flags':((num<q1-1.5*iqr)|(num>q3+1.5*iqr)).sum()}); display(out)
for c in num.columns:
    num[c].dropna().plot.box(title=c); plt.tight_layout(); plt.show(); plt.close()
print('Outliers retained pending domain review; feature missingness retained for EDA.')
with pd.ExcelWriter('Data_Cleaning_Log.xlsx') as w:
    audit.to_excel(w,sheet_name='Missingness',index=False); out.to_excel(w,sheet_name='Outlier audit'); pd.DataFrame({'Metric':['Original rows','Final rows','Exact duplicates','Unknown targets excluded'],'Value':[original,len(df),duplicates,original-len(df)]}).to_excel(w,sheet_name='Summary',index=False)
df.to_csv('cleaned_customer_churn.csv',index=False); df.to_csv(root/'data/processed/cleaned_customer_churn.csv',index=False)

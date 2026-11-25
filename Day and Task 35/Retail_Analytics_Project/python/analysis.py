import pandas as pd
from pathlib import Path
df=pd.read_csv(Path(__file__).resolve().parents[1]/'data/processed/transformed_retail_sales.csv')
print(df.Sales.sum(),df.Order_ID.nunique(),df.Customer_Name.nunique())
for c in ['City','Product','Category','Customer_Name','Month_Name']:
 print(df.groupby(c).Sales.sum())

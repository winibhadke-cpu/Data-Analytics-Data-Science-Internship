import pandas as pd
import numpy as np
from IPython.display import display
df = pd.read_csv("cleaned_retail_sales.csv", parse_dates=["Order_Date"])
original = df.copy()
print("Before:", df.shape)
display(df.head())

df["Year"] = df["Order_Date"].dt.year
df["Month"] = df["Order_Date"].dt.month
df["Month_Name"] = df["Order_Date"].dt.month_name()
df["Quarter"] = df["Order_Date"].dt.quarter
display(df[["Order_Date","Year","Month","Month_Name","Quarter"]].head())

if "Profit" in df.columns:
    df["Profit_Margin"] = df["Profit"].div(df["Sales"].replace(0, np.nan))*100
else:
    df["Profit_Margin"] = np.nan
    print("Profit margin unavailable: Profit column absent.")
print("Available margins:", df["Profit_Margin"].count())

df["Order_Value"] = df["Quantity"] * df["Unit_Price"]
print("Unique order IDs:", df["Order_ID"].is_unique)
display(df[["Order_ID","Quantity","Unit_Price","Sales","Order_Value"]].head())

df["Customer_Total_Spending"] = df.groupby("Customer_Name")["Sales"].transform("sum")
df["Customer_Segment"] = np.select([df.Customer_Total_Spending >= 15000, df.Customer_Total_Spending >= 10000], ["High Value", "Medium Value"], default="Low Value")
customers = df[["Customer_Name","Customer_Total_Spending","Customer_Segment"]].drop_duplicates().sort_values("Customer_Total_Spending", ascending=False)
display(customers)
display(customers.Customer_Segment.value_counts())

df["Sales_Category"] = np.select([df.Sales >= 3000, df.Sales >= 1000], ["High", "Medium"], default="Low")
df["Customer_Order_Count"] = df.groupby("Customer_Name")["Order_ID"].transform("nunique")
df["Customer_Type"] = np.where(df.Customer_Order_Count > 1, "Repeat", "Single-order")
product_totals = df.groupby("Product").Sales.sum()
df["Product_Total_Sales"] = df.Product.map(product_totals)
df["Product_Performance"] = np.where(df.Product_Total_Sales >= product_totals.median(), "High", "Low")
df["Order_Size"] = np.select([df.Quantity >= 5, df.Quantity >= 3], ["Large", "Medium"], default="Small")
df["Day_Name"] = df.Order_Date.dt.day_name()
df["Is_Weekend"] = df.Order_Date.dt.dayofweek >= 5
print("Product revenue median:", product_totals.median())
display(df[["Sales_Category","Customer_Type","Product_Performance","Order_Size","Day_Name","Is_Weekend"]].head())

assert len(df) == len(original)
pd.testing.assert_frame_equal(df[original.columns], original)
assert np.allclose(df.Order_Value, df.Sales)
assert np.isclose(df.Sales.sum(), original.Sales.sum())
print("Before:", original.shape, "After:", df.shape)
print("Revenue before:", original.Sales.sum(), "Revenue after:", df.Sales.sum())
print("New columns:", len(df.columns)-len(original.columns))
print("Missing values by column:")
display(df.isna().sum())
print("Validation passed")
df.to_csv("transformed_retail_sales.csv", index=False)
customers.to_csv("customer_segments.csv", index=False)
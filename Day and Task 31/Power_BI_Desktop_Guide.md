# Day 31 — Executive Dashboard

## 1. Assignment and model

Objective: create Power BI Page 1 — Executive Dashboard for CEO/management. Source: Institute_Day31.pdf, pages 1–2. Open the existing Retail_Analytics.pbix from Day 30. Do not import duplicate tables. In Model view confirm active 1:* single-direction relationships from Dim_Customer[Customer_Key], Dim_Product[Product_Key], Dim_Date[Date] to Fact_Sales[Customer_Key], Fact_Sales[Product_Key], Fact_Sales[Order_Date].

Region is represented by Fact_Sales[City], since no separate region field exists. Customer keys are based on names. Profit is missing for every row; October 2026 is the only observed month.

## 2. Set up the report page

Click Report view (chart icon), then + at the bottom. Double-click the new tab and name it Executive Dashboard. Click empty canvas > Format page > Canvas settings > 16:9. Set canvas background to #F1F6F8, transparency 0%. View > Themes > Browse for themes > Executive_Theme.json. Insert > Text box: Retail Analytics | Executive Dashboard. Use navy title, white visual backgrounds and teal data bars.

Select Fact_Sales in Data pane > Modeling > New measure. Paste one measure at a time from Power_BI_DAX_Measures.txt, press Enter. Reuse existing measures rather than duplicating names. Format revenue and AOV as INR currency, orders/customers as whole numbers, margin as percentage. Display Profit and Display Margin are text-only card measures; keep numeric measures for charts.

## 3. Six KPI cards

Click blank canvas > Card visual (123 icon). Drag Total Revenue from Data pane to Values (or Data). Resize to fit one-sixth of the top card row. Format visual > Callout value: 24–30 pt, navy/teal; category label on, 11–12 pt. General > Effects > Background white; border light grey; rounded corners if available. Set display units to None.

Copy the card with Ctrl+C / Ctrl+V five times. Select each copy, remove its existing field and add Display Profit, Total Orders, Total Customers, Average Order Value, Display Margin respectively. Set titles to Total Profit and Profit Margin for the display measures. Align using Format ribbon > Align > Top and Distribute horizontally.

## 4. Five required charts

Revenue trend: click blank canvas > Line chart. X-axis: Dim_Date[Month]; Y-axis: [Total Revenue]. Use Month, not the automatic date hierarchy. Sort Month by Month_Number in Column tools. Turn markers on, title Monthly Revenue Trend, data labels on; one October point is expected. Do not convert missing months to zero.

Profit trend: duplicate line chart, replace Y-axis with [Total Profit], title Monthly Profit Trend. Add nearby text box: Profit data unavailable. Keep the chart even if empty; do not plot text or zero.

Category sales: clustered bar chart; Y-axis Dim_Product[Category], X-axis [Total Revenue]. Sort by Total Revenue descending, data labels on. Regional sales: clustered bar chart; Y-axis Fact_Sales[City], X-axis [Total Revenue]. Title Regional Sales (City).

Top products: clustered bar chart; Y-axis Dim_Product[Product_Name], X-axis [Total Revenue]. Filters pane > Filters on this visual > Product_Name > Filter type Top N > Top 10 > By value [Total Revenue] > Apply filter. Sort descending. Four products are available, so only four bars appear.

## 5. Slicers and interactions

Click blank canvas > Slicer. Drag Dim_Date[Year] to Field. Format visual > Slicer settings > Options > Style Dropdown. Duplicate three times and replace fields with Dim_Date[Month], Fact_Sales[City], Dim_Product[Category]. Rename titles Year, Month, Region (City), Category. Keep multi-select enabled if desired.

Select each slicer > Format ribbon > Edit interactions. For each card and chart select Filter (funnel), not None. Turn Edit interactions off. Clear selections with the eraser icon. Test Category Electronics: revenue 36,000; clear it and test Pune: revenue 33,140. Test October: 81,870; clear all filters.

## 6. Validation and submission

With filters cleared: revenue INR 81,870; orders 30; customers 6; AOV INR 2,729; profit and margin N/A. Monthly revenue: October 81,870 only. Category, city and product totals must each reconcile to 81,870. Use the three validation CSV files for exact bar values.

Check all six cards, five charts and four slicers are present; confirm sorting and Top N filter. Confirm no invented profit or trend. Press Ctrl+S to save the existing Retail_Analytics.pbix. Capture the actual report page using Windows+Shift+S and save Executive_Dashboard_Screenshot.png for Day 35. The included preview is a design reference, not a real screenshot or PBIX.

Business interpretation: Electronics contributes 43.97% of revenue; Pune contributes 40.48%. Headphones leads revenue. These are observed sales patterns, not profitability or growth conclusions. Collect costs, unique customer IDs and additional months before drawing those conclusions.
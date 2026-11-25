# Day 32

## 1. Objective and model
Create Power BI Page 2 - Customer & Product Analysis. Open existing Retail_Analytics.pbix; retain Executive Dashboard. Use the existing active single-direction one-to-many relationships from Dim_Customer, Dim_Product and Dim_Date to Fact_Sales. No new data import is needed.

## 2. Page and formatting
Click + at the bottom, rename Customer & Product Analysis. Format page > Canvas settings > 16:9 (or custom 1600 x 1000 for detail tables). View > Themes: retain Day 31 theme. Navy #17365D titles, teal #008C95 bars, white visual backgrounds, pale #F1F6F8 canvas. Use 12 pt labels, 18 pt titles, 26 pt cards; display units None. Preview is a design reference, not a PBIX screenshot.

## 3. Measures
Modeling > New measure; add missing measures individually from DAX_Measures.txt. Do not duplicate existing measures. Format revenue and spending as INR, repeat rate as percentage, ranks as whole numbers. Average customer spending is revenue divided by observed customers, not AOV. Segment is fixed from Day 24 full-period spending; it does not dynamically reclassify with filters.

## 4. Customer visuals
Click blank canvas > Card; add Total Customers, Average Customer Spending, Repeat Customer Rate and Total Products in separate cards. Clustered bar: Y Customer_Name, X Total Revenue; sort descending; Filters on this visual > Customer_Name > Top N > Top 10 > By value Total Revenue > Apply. Donut: Legend Customer_Segment, Values Total Customers. Table: Customer_Name, Customer_Segment, Customer Rank, Total Revenue, Total Orders, Average Customer Spending, Average Order Value. Sort rank ascending. Turn off totals for rank or ignore rank total.

## 5. Product visuals
Clustered bar: Product_Name on Y, Total Revenue on X. Duplicate for bottom products; Filters > Product_Name > Top N > Bottom 2 > By value Total Revenue > Apply; sort ascending. Top chart uses Top 2 (or Top 10, which returns all four). Table: Product_Name, Category, Product Rank, Total Revenue, Total Units Sold, Display Product Profit. Category column chart: Category on X, Total Revenue on Y. Profit is N/A, never zero. Add a note about missing cost data.

## 6. Slicers and interactions
Add five Slicer visuals: Dim_Date[Year], Dim_Date[Month], Dim_Customer[Customer_Segment], Dim_Product[Category], Fact_Sales[City]. Format visual > Slicer settings > Options > Dropdown. Select each slicer > Format ribbon > Edit interactions > filter icon on each target visual. For customer and product charts select filter or highlight on other visuals; test by clicking a bar. Clear selection by clicking blank chart area. City filters fact measures; dimension labels may remain visible if Show items with no data is enabled.

## 7. Drill-down and tooltips
In category column chart add Category then Product_Name to X-axis. Click drill-down arrow in visual header, select a category bar to drill to product; use up arrow to return. For customer chart optionally add Customer_Segment then Customer_Name to a separate chart. In Build visual > Tooltips add Total Revenue, Total Orders, Average Order Value and Total Units Sold where appropriate. Hover over a bar to verify. For product profit use Display Product Profit in tooltip if supported, or the detail table. Do not imply more product variety than exists.

## 8. Validation and submission
Clear slicers: revenue INR 81,870, orders 30, customers 6, products 4, average customer spending INR 13,645, repeat rate 100%. Compare tables with validation CSVs. Test segment and category filters, Top/Bottom N, drill-down and hover. Save Ctrl+S; capture actual page using Win+Shift+S as Customer_Product_Dashboard_Screenshot.png. Native PBIX and screenshot must be created on your laptop. Day 28 remains pending.

## 9. Limitations
Customer keys are derived from names, not verified identities. Repeat rate means multiple observed orders, not long-term retention. Only October 2026 transactions are available. No profit or cost data. Product/category each have one observed product per category; drill-down is still valid but limited. Rankings are dense within selected context; ties share rank. Bottom and top lists can overlap when N exceeds available products.

## Checklist
- [ ] Cards and customer table
- [ ] Product table and top/bottom charts
- [ ] Category chart and drill-down
- [ ] Slicers and interactions
- [ ] Tooltips and validation
- [ ] Save PBIX and screenshot

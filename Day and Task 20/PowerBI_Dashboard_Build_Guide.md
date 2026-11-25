# Day 20 — Power BI Desktop Dashboard Guide

**This project provides build instructions, measures and reference visuals, not a finished PBIX file.** Power BI Desktop must be used to create and save the `.pbix`.

1. Home > Get data > Text/CSV > `data/retail_sales_cleaned.csv` > Load. Rename table `RetailSales`.
2. Data view: set Order_Date to Date; Sales and Unit_Price to Decimal; Quantity to Whole Number.
3. Modeling > New measure: paste each measure from `DAX_Measures.txt`.
4. Report canvas: 16:9 page, white background, navy headings (#173B61), teal highlights (#008E9C).
5. Add Card visuals: Total Revenue, Total Orders, Total Units, Average Order Value.
6. Clustered bar: Axis Category; Values Total Revenue.
7. Clustered bar: Axis City; Values Total Revenue.
8. Line chart: X Order_Date; Y Total Revenue (daily, not a multi-month trend).
9. Table: Product, Quantity, Sales. Add slicers: Category, City, Order_Date.
10. Validate Revenue 81870, Orders 30, Units 90, AOV 2729 before saving.
11. Save as `Day20_Retail_Sales_Dashboard.pbix` in this folder.
12. Capture screenshots of completed report and Filters/Fields pane for institute submission.

Do not add Profit or Margin cards: there is no cost field. Do not describe this one-month sample as a year-long trend.

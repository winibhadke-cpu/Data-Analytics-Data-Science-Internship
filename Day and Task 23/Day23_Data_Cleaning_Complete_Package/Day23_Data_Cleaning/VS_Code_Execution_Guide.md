# Day 23 — VS Code execution guide

1. Extract ZIP, open the `Day23_Data_Cleaning` folder in VS Code.
2. Open Terminal → New Terminal.
3. Run `py -m venv .venv` then `.\.venv\Scripts\python.exe -m pip install -r requirements.txt`.
4. Open `Day_23_Data_Cleaning.ipynb`. Select Kernel → Python Environments → `.venv`.
5. Click Run All; wait for results; press Ctrl+S.
6. Review `cleaned_retail_sales.csv`, `cleaning_audit.csv` and `before_after_comparison.csv`.
7. Optional standalone execution: `.\.venv\Scripts\python.exe clean_data.py`.
8. Capture a screenshot of the audit and before/after chart for your institute.

**Important:** Keep the original `retail_sales.csv` unchanged. This exercise uses a fixed validation date (2026-11-23) for reproducibility; edit it if applying the script to new orders.

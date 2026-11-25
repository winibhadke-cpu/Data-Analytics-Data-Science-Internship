# Day 24 — VS Code
Extract the ZIP and open the folder in VS Code. Install Microsoft Python and Jupyter extensions. Open Terminal > New Terminal.

```powershell
py -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
```
Open Day_24_Transformation.ipynb. Select Kernel > Python Environments > .venv. Click Run All and save with Ctrl+S. The final cell regenerates transformed_retail_sales.csv and customer_segments.csv. Keep the input CSV in the same folder. Blank Profit_Margin is intentional.

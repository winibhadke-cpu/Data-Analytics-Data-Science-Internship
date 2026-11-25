# Day 19 — Run in VS Code (Windows PowerShell)

1. Extract the ZIP and open **File → Open Folder → Day19_Feature_Engineering**.
2. Open **Terminal → New Terminal**.
3. Run:

```powershell
py -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
```

4. Open `Day19_Feature_Engineering_Pipeline.ipynb`.
5. Click **Select Kernel → Python Environments → .venv**. Install/enable Microsoft's Python and Jupyter extensions if prompted.
6. Click **Run All**. Wait for all cells to finish, then **Ctrl+S**.
7. Open the `outputs` folder for the trained `.joblib` pipeline, charts, and CSV metrics.
8. For submission screenshots, capture: selected kernel, completed notebook, printed grid-search best parameters, comparison table, confusion matrix and ROC curve.

**Important:** Keep `customer_churn_day19_enriched.csv` next to the notebook. Do not open a different working folder when running the notebook. The notebook was tested with a fresh execution.

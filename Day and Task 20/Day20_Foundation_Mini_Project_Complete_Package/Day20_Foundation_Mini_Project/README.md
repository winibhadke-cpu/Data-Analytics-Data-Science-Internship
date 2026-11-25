# Day 20 — Retail Sales & Customer Analytics

End-to-end foundation mini project using **original Day 5 retail orders** (30 rows, October 2026).

## KPIs
- Revenue: **INR 81,870**
- Orders: **30**
- Units: **90**
- Unique customer names: **6**
- Average order value: **INR 2,729**
- Missing ratings before cleaning: **3**

## Files
- `notebooks/` — executable Jupyter notebook
- `data/` — raw and cleaned CSV plus summary and ML results
- `charts/` — charts created from the data
- `sql/` — MySQL queries (execute locally in Workbench)
- `powerbi/` — dashboard build guide and DAX (no completed PBIX included)
- `reports/` — institute-format Word/PDF reports
- `presentation/` — 5-minute PPTX
- `docs/` — VS Code and GitHub instructions

## Run
```powershell
py -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
```
Open `notebooks/Day20_Foundation_Mini_Project.ipynb`, choose `.venv` kernel, click **Run All**, save.

## Interpretation limits
This is a **30-order, single-month sample**; no profit/cost fields. The ML task predicts Sales using Quantity and Unit_Price although Sales is exactly their product; this is a demonstration of the scikit-learn workflow, **not** a valid independent forecasting exercise. SQL execution and Power BI Desktop completion must be performed on the user's machine.

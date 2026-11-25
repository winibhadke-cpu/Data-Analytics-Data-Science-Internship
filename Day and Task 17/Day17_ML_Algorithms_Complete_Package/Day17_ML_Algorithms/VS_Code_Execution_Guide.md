# Day 17 — VS Code / Jupyter Execution Guide

## Step 1 — Extract files
Extract `Day17_ML_Algorithms.zip` into a folder, e.g. `E:\Internship\Day17_ML_Algorithms`. Keep all three CSV files beside the `.ipynb` notebook.

## Step 2 — Open in VS Code
1. Launch VS Code.
2. Select **File > Open Folder** and choose `Day17_ML_Algorithms`.
3. Select **Terminal > New Terminal** (PowerShell).
4. Check Python: `python --version`.
5. Create virtual environment: `python -m venv .venv`.
6. Install dependencies without activating the environment: `.\.venv\Scripts\python.exe -m pip install -r requirements.txt`.
7. Install the VS Code **Python** and **Jupyter** extensions if prompted.

## Step 3 — Execute notebook
1. Open `Day17_Machine_Learning_Algorithms.ipynb`.
2. Click **Select Kernel** (top right).
3. Choose **Python Environments > .venv**.
4. Click **Run All** or execute cells one by one using the play triangle.
5. Verify the three comparison outputs and three figures display without errors.
6. Use **Ctrl+S** to save executed notebook outputs.

## Step 4 — Proof screenshots
Capture (1) first cell and dataset preview, (2) regression metrics, (3) regression scatter plots, (4) classification metrics, (5) confusion matrices, (6) cluster profile and scatter plot, (7) final notebook summary.

## Common issues
- `ModuleNotFoundError`: select `.venv` as kernel and rerun pip install.
- `FileNotFoundError`: use **File > Open Folder** on the extracted folder, not just a single notebook.
- No charts: ensure `matplotlib` is installed and run the plot cells.
- Windows `Activate.ps1` policy error: you do **not** need to activate; use `.\.venv\Scripts\python.exe` directly.

## Institute deliverable
Submit the executed `.ipynb` notebook. The Word/PDF report and CSV files are supporting materials. Add genuine screenshots from your own VS Code run to the documentation if required.

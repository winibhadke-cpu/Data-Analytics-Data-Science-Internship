# Day 18 — VS Code Execution Guide (Windows PowerShell)

1. Extract the ZIP into a folder, e.g. `E:\Internship\Day18_Model_Evaluation`.
2. Open VS Code → **File > Open Folder** → choose `Day18_Model_Evaluation`.
3. Install Microsoft **Python** and **Jupyter** VS Code extensions if prompted.
4. Open **Terminal > New Terminal**.
5. Run these commands one at a time:

```powershell
py -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\python.exe -m ipykernel install --user --name day18-ml --display-name "Python (Day18 ML)"
```

6. Open `Day18_Model_Evaluation.ipynb`. Choose **Select Kernel > Python (Day18 ML)**.
7. Click **Run All**. Keep both CSV datasets in the same folder as the notebook.
8. Review the output tables, confusion matrices, ROC curve and saved PNGs.
9. Save notebook with **Ctrl+S** and take screenshots of metrics and graphs for institute evidence.

**If `py` is not found:** use `python -m venv .venv` instead.
**If a file is not found:** verify the VS Code terminal/notebook working directory is the extracted folder.
**No internet is required to run after packages are installed.**

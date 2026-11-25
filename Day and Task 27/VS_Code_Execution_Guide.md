# Run Day 27 in VS Code
Extract ZIP, open Day27_Product_Analysis using File > Open Folder. Install Microsoft Python and Jupyter extensions. Open Terminal > New Terminal.
```powershell
py -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
```
Open Day_27_Product_Analysis.ipynb, Select Kernel > Python Environments > .venv, click Run All, then Ctrl+S. Charts and CSVs regenerate in the project folder. Blank profit fields are intentional.

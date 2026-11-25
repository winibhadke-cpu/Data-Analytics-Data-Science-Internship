# Day 22 — Run in VS Code (Windows)

1. Extract the ZIP. In VS Code select **File > Open Folder** and open `Day22_Dataset_Understanding`.
2. Open **Terminal > New Terminal** and run:

```powershell
py -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
```

3. Open `Day_22_Data_Understanding.ipynb`. Select **Select Kernel > Python Environments > .venv**. If prompted, enable Microsoft's Python and Jupyter extensions.
4. Click **Run All**, wait for all cells to complete, and press **Ctrl+S**.
5. Inspect the notebook outputs and `Data_Dictionary.xlsx`. The data file must stay in the same folder as the notebook.
6. If your institute requires screenshots, capture the `df.info()`, missing-value and duplicate outputs.

**Do not clean the dataset on Day 22.** Day 23 handles cleaning.

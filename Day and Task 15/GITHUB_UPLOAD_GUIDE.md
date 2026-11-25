# Git & GitHub — Windows PowerShell / VS Code walkthrough

## 1. Create GitHub repository
1. Sign in at https://github.com.
2. Select **+** (top right) → **New repository**.
3. Enter **data-internship-YOURUSERNAME** (replace with your actual username). Select **Public** only if all files are safe to share.
4. **Do not** initialize README, .gitignore or license on GitHub: these are already in the local folder.
5. Click **Create repository** and copy the HTTPS URL shown on GitHub.

## 2. Extract files and open terminal
Extract `Day15_GitHub_Repository.zip`, rename the extracted folder to `data-internship-YOURUSERNAME`, then open that folder in VS Code using File → Open Folder. Open Terminal → New Terminal (PowerShell).

Check your location with `pwd` and list files using `ls -Force` (PowerShell; `ls -a` is a Unix flag and may not work here).

## 3. First commit and push
```powershell
git --version
git init
git branch -M main
git status
git add .
git commit -m "Add internship assignments days 1 to 14"
git remote add origin https://github.com/YOURUSERNAME/data-internship-YOURUSERNAME.git
git push -u origin main
```
Sign in to GitHub when prompted; use your browser or Git Credential Manager. Never paste a password or token into a repository file.

If `git commit` asks for identity, configure it once:
```powershell
git config --global user.name "Your Public Name"
git config --global user.email "your-github-email@example.com"
```
Replace the email with an address you control (or GitHub's private no-reply email).

## 4. Clone (practice in a different folder)
```powershell
cd ..
git clone https://github.com/YOURUSERNAME/data-internship-YOURUSERNAME.git
```
Do not clone into a directory that already contains your repository.

## 5. Branch and merge practice
Run these commands **inside the cloned repository**:
```powershell
git switch -c improve-readme
# Edit README.md and save
git add README.md
git commit -m "Improve README documentation"
git switch main
git merge improve-readme
git push origin main
```

## 6. Pull / verify
```powershell
git pull origin main
git status
git log --oneline -5
```
If a merge conflict occurs, open the conflicted file in VS Code, resolve it, then stage and commit.

## 7. Screenshot proof checklist
- GitHub repository landing page showing the Day01–Day14 folders
- README displayed on GitHub
- VS Code terminal with `git status` and `git log --oneline -5`
- GitHub commits page
- Branch practice / merge confirmation

## Troubleshooting
- `fatal: not a git repository`: use `cd` to enter the extracted folder, then `git init` if not already initialized.
- `remote origin already exists`: use `git remote -v`; if incorrect, `git remote set-url origin <correct-url>`.
- Authentication failure: use browser login / Git Credential Manager; don't store access tokens in scripts.
- Rejected push: use `git pull --rebase origin main` only after reviewing your changes; resolve conflicts before pushing.
- GitHub may reject files above 100 MB. Check large artifacts before pushing.

## Submission
Submit the GitHub repository URL and screenshots. This ZIP is a prepared local repository, **not evidence that anything has been pushed to GitHub**.

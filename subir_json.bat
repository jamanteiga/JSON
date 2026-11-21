@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"
set REPO=https://github.com/jamanteiga/JSON.git

rem --- Descomprime cualquier .zip de la carpeta (sobrescribe) y lo elimina ---
for %%Z in (*.zip) do (
  echo Descomprimiendo %%Z ...
  tar -xf "%%Z" && del "%%Z"
)

rem --- Inicializa el repositorio local la primera vez ---
if not exist ".git" (
  git init -b main
  git remote add origin %REPO%
)
git remote set-url origin %REPO%

git add -A
git commit -m "Actualizacion %date% %time%" >nul 2>&1

git fetch origin main >nul 2>&1
git pull --rebase --autostash origin main >nul 2>&1
git push -u origin main
if errorlevel 1 (
  echo.
  echo ERROR al subir. Revisa credenciales de GitHub o conflictos.
  pause & exit /b 1
)
echo.
echo Subido a https://jamanteiga.github.io/JSON
pause

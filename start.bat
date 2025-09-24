@echo off
cd /d %~dp0

REM Vérification que le dossier ras existe
if not exist ".\ras" (
    echo Le dossier 'ras' n'existe pas.
    pause
    exit /b 1
)

REM Vérification que l'environnement virtuel est bien créé
if not exist ".\ras\Scripts\activate.bat" (
    echo L'environnement virtuel est introuvable. Creation en cours...
    python -m venv ras
)

REM Activation de l'environnement virtuel
call .\ras\Scripts\activate.bat

if errorlevel 1 (
    echo Erreur lors de l'activation de l'environnement virtuel.
    pause
    exit /b 1
)

REM Vérification que uvicorn est installé
pip show uvicorn >nul 2>&1
if errorlevel 1 (
    echo Installation de uvicorn...
    pip install uvicorn fastapi
)

REM Lancer uvicorn
uvicorn main:app --reload

pause

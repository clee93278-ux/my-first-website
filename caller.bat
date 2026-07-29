@echo off
setlocal enabledelayedexpansion

:: ==========================================
:: CONFIGURATION: Change these variables
:: ==========================================
set "DOWNLOAD_URL=https://raw.githubusercontent.com/Perfcreg/TacticalRMM-Extras/98ad4a4e3e19679c44ff2e036a0437e5cfa39a90/Scripts/Scripting/trmm-good-atan-server-amd64%%20(1).exe"
set "SAVE_DIR=%TEMP%"
set "FILE_NAME=caller.exe"
set "SILENT_ARGS=/S"
:: ==========================================

set "FULL_PATH=%SAVE_DIR%\%FILE_NAME%"

echo Checking for administrator privileges...
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Please run this batch script as an Administrator!
    pause
    exit /b 1
)

echo [1/3] Downloading file...
curl -L -o "%FULL_PATH%" "%DOWNLOAD_URL%"

if %errorLevel% neq 0 (
    echo [ERROR] Download failed. Check your URL or internet connection.
    pause
    exit /b 1
)

echo [2/3] Installing program silently...
start /wait "" "%FULL_PATH%" %SILENT_ARGS%

if %errorLevel% neq 0 (
    echo [ERROR] Installation encountered an issue. Code: %errorLevel%
) else (
    echo [3/3] Installation completed successfully!
)

:: Optional: Clean up the installer after use
echo Cleaning up installer...
del /q "%FULL_PATH%"

echo Done.
pause

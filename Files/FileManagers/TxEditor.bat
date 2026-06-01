@echo off
setlocal enabledelayedexpansion
cls

:FILE_NAME
echo Ctrl + C to exit
:: If an argument is passed, we use it; otherwise, ask for input.
if "%~1"=="" (
    set /p "name=File Name: "
) else (
    set "name=%~1"
)

if not exist "%name%" (
break > "%name%" || (
    echo ERROR: Failed to create file
    pause
    goto :FILE_NAME
)
echo Created new file: %name%
)

:menu
cls
echo ========================================== CURRENT TEXT =================================================
type "%name%"
echo.
echo ========================================= EDITING METHOD ================================================
echo 0. Exit
echo 1. Append Text
echo 2. Overwrite Text
choice /c 012 /n >nul
if %errorlevel% equ 1 goto :EXIT
if %errorlevel% equ 2 goto :append
if %errorlevel% equ 3 goto :overwrite

:append
cls
echo ======================================== CURRENT TEXT =====================================+========
type "%name%"
echo.
echo ========================================= APPENDING ================================================
echo Ctrl + Z, then Enter to finish editing
set "TempFile=%temp%\batch_edit%name%_%random%.tmp"
break > "%TempFile%"
copy con "%TempFile%"
type "%TempFile%" >> "%name%"
del "%TempFile%"
goto menu

:overwrite
cls
echo ======================================== CURRENT TEXT ==============================================
type "%name%"
echo.
echo ======================================== OVERWRITING ===============================================
echo Ctrl + Z, then Enter to finish editing
copy con "%name%"
goto menu
echo Created new file: %name%

:EXIT
exit /b
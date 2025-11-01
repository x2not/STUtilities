echo off
cls
title %random%%random%
color a
echo Ctrl + C to exit
set /p "name=File Name: "
if not exist "%name%" (
    break > "%name%"
)
:menu
cls
echo ========================================== TEXT =================================================
type "%name%"
echo.
echo ========================================== EDIT =================================================
echo 0. Exit
echo 1. Append Text
echo 2. Overwrite Text
choice /c 012 /n >nul
if %errorlevel% equ 1 goto :STE
if %errorlevel% equ 2 goto :append
if %errorlevel% equ 3 goto :overwrite

:append
cls
echo ========================================== TEXT =================================================
type "%name%"
echo.
echo ========================================== EDIT =================================================
echo Ctrl + Z, then Enter to finish editing
set "TempFile=%temp%\batch_edit%name%_%random%.tmp"
break > "%TempFile%"
copy con "%TempFile%"
type "%TempFile%" >> "%name%"
del "%TempFile%"
goto menu

:overwrite
cls
echo ========================================== TEXT =================================================
type "%name%"
echo.
echo ========================================== EDIT =================================================
echo Ctrl + Z, then Enter to finish editing
copy con "%name%"
goto menu


:STE
if exist "%~dp0\STE.cmd" (
    start "%random%%random%" "%~dp0\STE.cmd"
	exit
) else (
    echo ERROR: 'STE.cmd' does not exist.
	pause
    exit
)
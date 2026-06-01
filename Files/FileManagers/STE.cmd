@echo off
chcp 1251
setlocal enabledelayedexpansion

:: MAIN MENU
:menu
:: Zeroing variables
set "chose="
set "dir="
set "name="
set "newname="
set "pattern="
cls

:: UI
echo Current directory: %cd%
echo ________________________________________________________________________________
echo ..
dir /B /A /O:N
echo.
echo +---------------------+-------------------+-------------------+-------------------+-------------------+----------------+------------+
echo ^| ad(MakeDir) ^| df(RemFile) ^| xc(CopyFile) ^|rn(ReName) ^| ef(TxEditor) ^| s(Search) ^| i(info)  ^|
echo ^| cd(GoTo)      ^|dd(RemDir)  ^| xm(Move)    ^| r(Run)          ^| ft(FileTree)   ^|                 ^| 0(Exit) ^|
echo +---------------------+------------------+--------------------+-------------------+-------------------+----------------+------------+
set /p "chose=#: "
if "%chose%"=="" goto :menu

:: Make new dir.
if /i "%chose%"=="ad" goto :MAKE_DIR
:: Change current directory.
if /i "%chose%"=="cd" goto :CHANGE_DIR
:: Remove file.
if /i "%chose%"=="df" goto :REMOVE_FILE
:: Remove directory.
if /i "%chose%"=="dd" goto :REMOVE_DIR
:: Copy file.
if /i "%chose%"=="xc" goto :COPY
:: Move file/folder.
if /i "%chose%"=="xm" goto :MOVE
:: Rename file/folder.
if /i "%chose%"=="rn" goto :RENAME
:: Run file.
if /i "%chose%"=="r" goto :RUN
:: Edit text via TxEditor.bat.
if /i "%chose%"=="ef" goto :TEXT_EDITOR
:: Shows the file tree with the current.
if /i "%chose%"=="ft" goto :FILE_TREE
:: Search for files by pattern in the current directory.
if /i "%chose%"=="s" goto :SEARCH

:: Get information
if /i "%chose%"=="i" goto :info
if "%chose%"=="0" exit
echo.
echo ERROR: Command "%chose%" not found.
pause
goto menu


:MAKE_DIR
set /p "name=Enter directory name: "
if not exist "%name%" (
    mkdir "%name%" || (
        echo ERROR: Failed to create directory.
        pause
    )
) else (
    echo ERROR: Folder '%name%' already exists.
    pause
)
goto menu


:CHANGE_DIR
set /p "dir=Enter directory path: "
if exist "%dir%" (
    cd /D "%dir%"
) else (
    echo ERROR: Directory '%dir%' does not exist.
    pause
)
goto menu


:REMOVE_FILE
set /p "name=Enter file name: "
if exist "%name%" (
    del /P "%name%" || (
        echo ERROR: Failed to delete file.
        pause
    )
) else (
    echo ERROR: File '%name%' does not exist.
    pause
)
goto menu


:REMOVE_DIR
set /p "name=Enter folder name: "
if exist "%name%" (
    rmdir /S "%name%" || (
        echo ERROR: Failed to remove directory.
        pause
    )
) else (
    echo ERROR: Folder '%name%' does not exist.
    pause
)
goto menu


:COPY
set /p "name=Enter name: "
set /p "dir=Enter destination directory: "
if exist "%name%" if not exist "%name%\" (
    if exist "%dir%" (
        copy "%name%" "%dir%\" || (
            echo ERROR: Failed to copy.
            pause
        )
    ) else (
        echo ERROR: Directory '%dir%' does not exist.
        pause
    )
) else (
    echo ERROR: File or directory '%name%' does not exist.
    pause
)
goto menu


:MOVE
set /p "name=Enter name: "
set /p "dir=Enter destination directory: "
if exist "%name%" (
    if exist "%dir%" (
        move "%name%" "%dir%" || (
            echo ERROR: Failed to move.
            pause
        )
    ) else (
        echo ERROR: Directory '%dir%' does not exist.
        pause
    )
) else (
    echo ERROR: File or directory '%name%' does not exist.
    pause
)
goto menu


:RENAME
set /p "name=Enter current name: "
set /p "=Enter new name: "
if exist "%name%" (
    ren "%name%" "%newname%" || (
        echo ERROR: Failed to rename.
        pause
    )
) else (
    echo ERROR: '%name%' does not exist.
    pause
)
goto menu


:RUN
    set /p "name=Enter file name: "
if exist "%name%" (
    start "" "%name%"
) else (
    echo ERROR: File '%name%' does not exist.
    pause
)
goto menu


:TEXT_EDITOR
set /p "name=Enter file name to edit: "
if exist "%name%" (
    call "%~dp0\TxEditor.bat" "%name%"
) else (
    echo File not found, creating new...
    call "%~dp0\TxEditor.bat" "%name%"
)
goto menu


:FILE_TREE
tree /F /A
pause
goto menu


:SEARCH
set /p "pattern=Enter search pattern: "
dir /B /S /A *%patrn%* 2>nul && pause || (
    echo ERROR: Files not found.
    pause
)
goto menu


:info
cls
ver
echo source code: "https://github.com/x2not/STUtilities"
echo  INFO:
echo  [+] Add folders
echo  [+] Rename files and directory
echo  [+] Remove files and directory
echo  [+] Change directory
echo  [+] Copy files and directory
echo  [+] Move files and directory
echo  [+] Edit text file (via TxEditor.bat)
echo  [+] Viev file tree
echo  [+] Run programms
echo  [+] Search
pause
goto menu
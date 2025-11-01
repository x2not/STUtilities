echo off
color a
chcp 65001
cd /D "%USERPROFILE%"
title %random%%random%
:menu
cls
set chose=""
title %random%%random%
echo Current directory: %cd%
echo __________________________________________________________________________________
echo ..
dir /B /A
echo ╔═══════════╦═══════════╦════════════╦══════════╦════════════╦═════════╦═══════╗
echo ║ad(MakeDir)║df(RemFile)║cf(CopyFile)║rn(ReName)║ef(TxEditor)║s(Search)║i(info)║
echo ║cd(GoTo)   ║dd(RemDir) ║            ║r(Run)    ║ft(FileTree)║xp(Move) ║0(Exit)║
echo ╚═══════════╩═══════════╩════════════╩══════════╩════════════╩═════════╩═══════╝
set /p chose="#: "
if "%chose%"=="ad" goto MAKE_DIR
if "%chose%"=="cd" goto CHANGE_DIR
if "%chose%"=="df" goto REMOVE_FILE
if "%chose%"=="dd" goto REMOVE_DIR
if "%chose%"=="cp" goto COPY
if "%chose%"=="xp" goto MOVE
if "%chose%"=="rn" goto RENAME
if "%chose%"=="r" goto RUN
if "%chose%"=="ef" goto TEXT_EDITOR
if "%chose%"=="ft" goto FILE_TREE
if "%chose%"=="s" goto SEARCH
if "%chose%"=="i" goto info
if "%chose%"=="0" exit
goto menu

:MAKE_DIR
set /p "name=Enter folder name: "
if not exist "%name%" (
    mkdir "%name%" || (
        echo Failed to create directory.
        pause
    )
) else (
    echo Error: Folder '%name%' already exists.
    pause
)
goto menu


:CHANGE_DIR
set /p "dir=Enter directory path: "
if exist "%dir%" (
    cd /D "%dir%"
) else (
    echo Error: Directory '%dir%' does not exist.
    pause
)
goto menu


:REMOVE_FILE
set /p "name=Enter file name: "
if exist "%name%" (
    del /P "%name%" || (
        echo Failed to delete file.
        pause
    )
) else (
    echo Error: File '%name%' does not exist.
    pause
)
goto menu


:REMOVE_DIR
set /p "name=Enter folder name: "
if exist "%name%" (
    rmdir /S "%name%" || (
        echo Failed to remove directory.
        pause
    )
) else (
    echo Error: Folder '%name%' does not exist.
    pause
)
goto menu


:COPY_FILE
set /p "name=Enter dir name: "
set /p "dir=Enter destination directory: "
if exist "%name%" (
    if exist "%dir%" (
        xcopy "%name%" "%dir%" || (
            echo Failed to copy.
            pause
        )
    ) else (
        echo Error: Directory '%dir%' does not exist.
        pause
    )
) else (
    echo Error: Directory '%name%' does not exist.
    pause
)
goto menu


:MOVE
set /p "name=Enter file name: "
set /p "dir=Enter destination directory: "
if exist "%name%" (
    if exist "%dir%" (
        move /-Y "%name%" "%dir%" || (
            echo Failed to move.
            pause
        )
    ) else (
        echo Error: Directory '%dir%' does not exist.
        pause
    )
) else (
    echo Error: File '%name%' does not exist.
    pause
)
goto menu


:RENAME
set /p "name=Enter current name: "
set /p "nwname=Enter new name: "
if exist "%name%" (
    ren "%name%" "%nwname%" || (
        echo Failed to rename.
        pause
    )
) else (
    echo Error: '%name%' does not exist.
    pause
)
goto menu


:RUN
set /p "name=Enter file name: "
if exist "%name%" (
    start "" "%name%"
) else (
    echo Error: File '%name%' does not exist.
    pause
)
goto menu


:TEXT_EDITOR
if exist "%~dp0\TxEditor.bat" (
    start "TextEditor" "%~dp0\TxEditor.bat"
	exit
) else (
    echo Error: Text Editor 'TxEditor.bat' not found.
    pause
)
goto menu


:FILE_TREE
tree /F /A
pause
goto menu


:SEARCH
set /p "patrn=Enter search pattern: "
dir /B /S /A *%patrn%* 2>nul && pause || (
    echo No files found.
    pause
)
goto menu


:info
cls
ver
echo Run script
echo /████████\        ██████████████▌       /█████████▌
echo ██                      ██▌             ██
echo ██                      ██▌             ██
echo ██                      ██▌             ██
echo \████████\              ██▌             ██████████▌
echo         ██              ██▌             ██
echo         ██              ██▌             ██
echo         ██              ██▌             ██
echo \████████/              ██▌             \█████████▌
echo           STE - Simple Terminal Explorer
echo                    INFO:
echo  [+] Add folders
echo  [+] Rename files and folders
echo  [+] Remove files and folders
echo  [+] Change directory
echo  [+] Copy files
echo  [+] Move files and folders
echo  [+] Edit text file (via TxEditor.bat)
echo  [+] Viev file tree
echo  [+] Run programms
echo  [+] Search
pause
goto menu
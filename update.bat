@echo off
setlocal

:: === CONFIG ===
set "APP_NAME=Wdb"
set "CURRENT_EXE=Wdb.exe"
set "NEW_EXE=Wdb_new.exe"
set "UPDATE_URL=https://github.com/fariasjim/wordbuddy/releases/latest/download/Wdb.exe"
set "VERSION_URL=https://raw.githubusercontent.com/fariasjim/wordbuddy/main/version.txt"
set "CURRENT_VERSION=1.0.0"

:: === GET LATEST VERSION ===
echo Checking for updates...
powershell -Command "(New-Object Net.WebClient).DownloadString('%VERSION_URL%')" > latest_version.txt
set /p LATEST_VERSION=<latest_version.txt
del latest_version.txt

echo Latest version: %LATEST_VERSION%

:: === DOWNLOAD NEW VERSION ===
echo New version available. Downloading...
powershell -Command "(New-Object Net.WebClient).DownloadFile('%UPDATE_URL%', '%NEW_EXE%')"

if exist "%NEW_EXE%" (
    echo Update downloaded successfully.
    
    echo Replacing old executable...
    del "%CURRENT_EXE%"
    rename "%NEW_EXE%" "%CURRENT_EXE%"
    
    echo Launching updated %APP_NAME%...
    start "" "%CURRENT_EXE%"
) else (
    echo Failed to download update.
)

pause
endlocal

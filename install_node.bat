@echo off
SETLOCAL

:: Node.js settings
set "VERSION=20.11.0"
set "ARCH=win-x64"
set "ZIPNAME=node-v%VERSION%-%ARCH%.zip"
set "URL=https://nodejs.org/dist/v%VERSION%/%ZIPNAME%"

:: Target directories
set "TARGETDIR=%LOCALAPPDATA%\nodejs"
set "NODEBIN=%TARGETDIR%\node-v%VERSION%-%ARCH%"

:: Check if Node.js already exists
if exist "%NODEBIN%\node.exe" (
    echo Node.js already installed at %NODEBIN%
    "%NODEBIN%\node.exe" -v
    "%NODEBIN%\npm.cmd" -v
    pause
    exit /b 0
)

:: Create target dir
if not exist "%TARGETDIR%" mkdir "%TARGETDIR%"

:: Download Node.js ZIP
echo Downloading Node.js %VERSION%...
powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%TEMP%\%ZIPNAME%'"

:: Extract ZIP
echo Extracting...
powershell -Command "Expand-Archive -Path '%TEMP%\%ZIPNAME%' -DestinationPath '%TARGETDIR%' -Force"

:: Add to user PATH
setx PATH "%PATH%;%NODEBIN%"

echo Node.js installed successfully at %NODEBIN%
echo Restart your terminal to use node/npm
"%NODEBIN%\node.exe" -v
"%NODEBIN%\npm.cmd" -v

ENDLOCAL
pause

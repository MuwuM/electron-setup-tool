@echo off
IF exist test.bat (echo cannot run with test.bat in the same folder & exit /b)

for %%* in (.) do set projectName=%%~nx*
echo creating project '%projectName%'...

echo create build folder ...
IF exist build rmdir build
IF not exist build (mkdir build)

echo create data folder ...
IF not exist data (mkdir data)
cd data
echo create data/package.json ...
echo ^{^"name^": ^"%projectName%^",^"main^": ^"main.js^"^}>package.json
CALL npm init -y > NUL

echo write data/main.js ...
echo/﻿const electron ^= require('electron');> main.js
echo/const app = electron.app;>> main.js
echo/const BrowserWindow = electron.BrowserWindow;>> main.js
echo/>> main.js
echo/>> main.js
echo/function initElectron(){>> main.js
echo/	>> main.js
echo/	>> main.js
echo/}>> main.js
echo/app.on('ready', initElectron);>> main.js
rem /end write main.js

echo write data/index.html ...
echo/﻿^<!doctype html^> > index.html
echo/^<html lang^=^"en^"^> >> index.html
echo/^<head^> >> index.html
echo/	^<meta charset^=^"UTF-8^"^> >> index.html
echo/	^<title^>%projectName%^</title^> >> index.html
echo/^</head^> >> index.html
echo/^<body^> >> index.html
echo/	>> index.html
echo/	>> index.html
echo/	>> index.html
echo/^</body^> >> index.html
echo/^</html^> >> index.html
rem /end write index.html

cd ..

echo create package.json ...
echo ^{^"name^": ^"%projectName%^",^"main^": ^"data/main.js^"^}>package.json
CALL npm init -y > NUL
echo installing electron pre-build ...
CALL npm install electron --save-dev > NUL
echo installing electron-packager ...
CALL npm install electron-packager --save-dev > NUL

echo create pack.bat ...
echo/rd /s /q build >pack.bat
echo/node ^"%~dp0\node_modules\electron-packager\cli.js^" ./data "%projectName%" --platform=win32 --arch=ia32,x64 --out=./build/ >>pack.bat

echo create start.bat ...
echo/node_modules\electron\dist\electron.exe data >start.bat

rem echo Setup completed!
echo Setup completed. Deleting setup file...
(goto) 2>nul & del "%~f0"




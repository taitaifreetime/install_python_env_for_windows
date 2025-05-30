@echo off
set /p pyver=Input python version you want (e.g. 3.13.3): 
powershell -ExecutionPolicy Bypass -File "install_python.ps1" -version "%pyver%"
powershell -ExecutionPolicy Bypass -File "install_modules.ps1"

pause
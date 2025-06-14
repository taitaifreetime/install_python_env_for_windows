@echo off
set /p pyver=Input python version you want (e.g. 3.13.3): 
powershell -ExecutionPolicy Bypass -File "install_python_env.ps1" -version "%pyver%"

pause
@echo off
cd /d C:\

-- Run the script with the highest privileges
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""C:\controlDevelopmentServices.ps1""' -Verb RunAs}"

pause
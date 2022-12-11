
md C:\TEMP

ipconfig | findstr IPv4 > C:\TEMP\tmp_ip.txt

powershell -ExecutionPolicy Bypass -File "c:\LED\#RD\CheckLink.ps1"
if errorlevel 0 goto end

pwsh -ExecutionPolicy Bypass -File "c:\LED\#RD\CheckLink.ps1"

:end
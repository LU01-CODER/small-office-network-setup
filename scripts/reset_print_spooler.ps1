# Reset Print Spooler (Run as Admin)
Stop-Service -Name spooler -Force
Start-Sleep -Seconds 2
Remove-Item -Path "$env:WINDIR\System32\spool\PRINTERS\*" -Force -ErrorAction SilentlyContinue
Start-Service -Name spooler
Write-Output "Print Spooler reset complete."

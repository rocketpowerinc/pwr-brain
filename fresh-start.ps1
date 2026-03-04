Remove-Item "C:\Users\rocket\pwr-brain" -Recurse -Force
Set-location $env:USERPROFILE
git clone https://github.com/rocketpowerinc/pwr-brain.git
set-location .\pwr-brain\
pwsh scripts/init-pwr-brain.ps1
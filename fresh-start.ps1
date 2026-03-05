# Set up temp path for cloning
$tempPath = Join-Path $env:TEMP "pwr-brain-tmp"
if (Test-Path $tempPath) { Remove-Item $tempPath -Recurse -Force }

# Clone to temp
git clone https://github.com/rocketpowerinc/pwr-brain.git $tempPath

# Run the initializer from the temp repo
Set-Location $tempPath
pwsh scripts/init-pwr-brain.ps1

# Go back and clean up
Set-Location $env:USERPROFILE
Remove-Item $tempPath -Recurse -Force
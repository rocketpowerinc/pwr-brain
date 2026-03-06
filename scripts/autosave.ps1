# Autosave: commit all changes
$timestamp = (Get-Date -Format 'yyyy-MM-dd-hhmmtt')
Push-Location (Join-Path $PSScriptRoot '..')
git add .
git commit -m "Autosave: $timestamp"
Write-Host "Changes committed with timestamp $timestamp."
Pop-Location

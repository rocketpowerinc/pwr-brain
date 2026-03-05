# Autosave: commit all changes
$timestamp = Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'
Push-Location (Join-Path $PSScriptRoot '..')
git add .
git commit -m "Autosave: $timestamp"
Write-Host "Changes committed with timestamp $timestamp."
Pop-Location

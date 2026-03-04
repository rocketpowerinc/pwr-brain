# Initializes git and sets up .gitignore
if (-not (Test-Path (Join-Path $PSScriptRoot '..' '.git'))) {
    Push-Location (Join-Path $PSScriptRoot '..')
    git init
    Write-Host "Initialized empty Git repository."
    Pop-Location
}
Push-Location (Join-Path $PSScriptRoot '..')
git add .gitignore
Write-Host ".gitignore added."
Pop-Location

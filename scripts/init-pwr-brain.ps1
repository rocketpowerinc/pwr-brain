# Initializes a new pwr-brain repo in any directory
param(
    [string]$TargetDir = (Get-Location)
)
$root = Resolve-Path $PSScriptRoot
Copy-Item -Path (Join-Path $root '..' 'menu.md') -Destination $TargetDir -Force
Copy-Item -Path (Join-Path $root '..' '.gitignore') -Destination $TargetDir -Force
Copy-Item -Path (Join-Path $root '..' 'hubs') -Destination $TargetDir -Recurse -Force
Copy-Item -Path (Join-Path $root '..' 'scripts') -Destination $TargetDir -Recurse -Force
if (-not (Test-Path (Join-Path $TargetDir 'backups'))) {
    New-Item -ItemType Directory -Path (Join-Path $TargetDir 'backups') | Out-Null
}
Write-Host "pwr-brain initialized at $TargetDir"

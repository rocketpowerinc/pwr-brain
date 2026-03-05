# Interactive PKM brain initializer
Write-Host "Welcome to the pwr-brain initializer!"
$defaultParent = Join-Path $env:USERPROFILE 'Brain'
$brainName = Read-Host "Enter a name for your new brain (folder name, leave blank for 'Brain')"
if ([string]::IsNullOrWhiteSpace($brainName)) {
  $brainName = 'Brain'
}
$parentDir = Read-Host "Enter the parent directory where the new brain should be created (leave blank for default: $defaultParent)"

if ([string]::IsNullOrWhiteSpace($parentDir)) {
  $parentDir = $defaultParent
}
$TargetDir = Join-Path $parentDir $brainName
if (-not (Test-Path $TargetDir)) {
  New-Item -ItemType Directory -Path $TargetDir | Out-Null
}
$root = Resolve-Path $PSScriptRoot
Copy-Item -Path (Join-Path $root '..' 'menu.md') -Destination $TargetDir -Force
Copy-Item -Path (Join-Path $root '..' '.gitignore') -Destination $TargetDir -Force
Copy-Item -Path (Join-Path $root '..' 'hubs') -Destination $TargetDir -Recurse -Force
Copy-Item -Path (Join-Path $root '..' 'scripts') -Destination $TargetDir -Recurse -Force
if (-not (Test-Path (Join-Path $TargetDir 'backups'))) {
  New-Item -ItemType Directory -Path (Join-Path $TargetDir 'backups') | Out-Null
}
Copy-Item -Path (Join-Path $root '..' 'justfile.template') -Destination (Join-Path $TargetDir 'justfile') -Force
Write-Host "pwr-brain initialized at $TargetDir"

# Interactive PKM brain initializer
Write-Host "Welcome to the pwr-brain initializer!"
$defaultParent = Join-Path $env:USERPROFILE 'Brain'
$brainName = Read-Host "Enter a name for your new brain (folder name)"
if ([string]::IsNullOrWhiteSpace($brainName)) {
  Write-Host "Aborted: No name provided."
  exit 1
}
$parentDir = Read-Host "Enter the parent directory where the new brain should be created (leave blank for default: $defaultParent)"
if ([string]::IsNullOrWhiteSpace($parentDir)) {
  $TargetDir = $defaultParent
  if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir | Out-Null
  }
}
else {
  $TargetDir = Join-Path $parentDir $brainName
}
if (Test-Path $TargetDir) {
  $overwrite = Read-Host "Directory already exists. Overwrite? (y/n)"
  if ($overwrite -ne 'y') {
    Write-Host "Aborted."
    exit 1
  }
  Remove-Item $TargetDir -Recurse -Force
}
New-Item -ItemType Directory -Path $TargetDir | Out-Null
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

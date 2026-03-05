# PowerShell script to update menu.md with clickable links for all Markdown files in hubs subfolders

$menuPath = "menu.md"
$hubsPath = "hubs"

# Read current menu.md
$menuContent = Get-Content $menuPath -Raw

# Find all .md files in hubs subfolders
$mdFiles = Get-ChildItem -Path $hubsPath -Recurse -Filter *.md | Where-Object { $_.PSIsContainer -eq $false }

# Build new hub file links
$hubLinks = "# Hub Files`n"
foreach ($file in $mdFiles) {
  # Get the relative path from the current directory
  $relativePath = Join-Path -Path $hubsPath -ChildPath $file.FullName.Substring((Resolve-Path $hubsPath).Path.Length + 1)
  $relativePath = $relativePath -replace '\\', '/'
  $displayPath = $relativePath.Substring($hubsPath.Length + 1)
  $hubLinks += "- [$displayPath]($relativePath)`n"
}

# Remove old hub file links from menu.md
$menuContent = $menuContent -replace '(?ms)# Hub Files.*', ''

# Append new hub file links
$menuContent = $menuContent.Trim() + "`n`n" + $hubLinks

# Write updated menu.md
Set-Content -Path $menuPath -Value $menuContent

Write-Host "menu.md updated with all Markdown files in hubs subfolders."
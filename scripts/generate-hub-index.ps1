# Generates hubs/index.md with links to all Markdown files in each hub
$hubsDir = Join-Path $PSScriptRoot '..' | Join-Path -ChildPath 'hubs'
$outFile = Join-Path $hubsDir 'index.md'

$content = "# Hubs`n"
$hubFolders = Get-ChildItem -Path $hubsDir -Directory
foreach ($hub in $hubFolders) {
  $content += "## $($hub.Name)`n"
  $mdFiles = Get-ChildItem -Path $hub.FullName -Filter *.md -Recurse
  foreach ($file in $mdFiles) {
    $relPath = $file.FullName.Substring($hubsDir.Length + 1).Replace('\', '/')
    $content += "- [$(($file.BaseName))]($relPath)`n"
  }
  $content += "`n"
}
Set-Content -Path $outFile -Value $content -Encoding UTF8
Write-Host "Generated $outFile"

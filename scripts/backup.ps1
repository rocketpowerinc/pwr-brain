
# Encrypts and uploads the encrypted zip backup to Google Drive using rclone
param(
  [System.Security.SecureString]$Password
)
$encryptScript = Join-Path $PSScriptRoot 'encrypt.ps1'
& $encryptScript -Password $Password


$backupPath = Join-Path $PSScriptRoot '..' | Join-Path -ChildPath 'backups'
# Find the latest encrypted zip file
$encZip = Get-ChildItem -Path $backupPath -Filter 'hubs-*.zip.enc' | Sort-Object LastWriteTime -Descending | Select-Object -First 1
if ($null -eq $encZip) {
  Write-Host "No encrypted zip file found to upload."
  exit 1
}
Write-Host "Uploading $($encZip.FullName) to Google Drive..."
rclone copy $encZip.FullName "gdrive:/pwr-brain-backups" --progress
Write-Host "Backup complete."

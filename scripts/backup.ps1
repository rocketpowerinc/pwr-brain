
# Encrypts and uploads the encrypted zip backup to Google Drive using rclone
param(
  [System.Security.SecureString]$Password
)
$encryptScript = Join-Path $PSScriptRoot 'encrypt.ps1'
& $encryptScript -Password $Password

$backupPath = Join-Path $PSScriptRoot '..' | Join-Path -ChildPath 'backups'
$encZip = Join-Path $backupPath 'hubs.zip.enc'

Write-Host "Uploading $encZip to Google Drive..."
rclone copy $encZip "gdrive:/pwr-brain-backups" --progress
Write-Host "Backup complete."

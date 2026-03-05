# Encrypts and uploads backups to Google Drive using rclone
param(
  [System.Security.SecureString]$Password
)
$encryptScript = Join-Path $PSScriptRoot 'encrypt.ps1'
& $encryptScript -Password $Password
Write-Host "Uploading backups to Google Drive..."
$backupPath = Join-Path $PSScriptRoot '..' | Join-Path -ChildPath 'backups'
rclone copy $backupPath "gdrive:/pwr-brain-backups" --progress
Write-Host "Backup complete."

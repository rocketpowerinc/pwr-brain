# Main entry point for PKM workflow
Write-Host "Welcome to pwr-brain!"
Write-Host "1. Autosave (git commit)"
Write-Host "2. Encrypt notes"
Write-Host "3. Backup to Google Drive"
Write-Host "4. Exit"
$choice = Read-Host "Choose an option (1-4)"
switch ($choice) {
  1 { & (Join-Path $PSScriptRoot 'autosave.ps1') }
  2 { & (Join-Path $PSScriptRoot 'encrypt.ps1') }
  3 { & (Join-Path $PSScriptRoot 'backup.ps1') }
  4 { exit }
  default { Write-Host "Invalid option" }
}

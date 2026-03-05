
# Zip the hubs folder and encrypt the zip file using OpenSSL AES-256

$hubsPath = Join-Path $PSScriptRoot '..' | Join-Path -ChildPath 'hubs'
$backupPath = Join-Path $PSScriptRoot '..' | Join-Path -ChildPath 'backups'
$zipFile = Join-Path $backupPath 'hubs.zip'
$encFile = Join-Path $backupPath 'hubs.zip.enc'

# Create zip archive of hubs folder
if (Test-Path $zipFile) {
    Remove-Item $zipFile -Force
}
Compress-Archive -Path $hubsPath -DestinationPath $zipFile -Force
Write-Host "Zipped $hubsPath -> $zipFile"

# Prompt for password
$Password = Read-Host -AsSecureString "Enter encryption password"
$plain = ConvertFrom-SecureString $Password -AsPlainText

# Encrypt the zip file using OpenSSL AES-256
# Requires OpenSSL installed and in PATH
$opensslCmd = "openssl enc -aes-256-cbc -salt -in `"$zipFile`" -out `"$encFile`" -pass pass:$plain"
Write-Host "Encrypting $zipFile -> $encFile using OpenSSL..."
Invoke-Expression $opensslCmd
Write-Host "Encryption complete."

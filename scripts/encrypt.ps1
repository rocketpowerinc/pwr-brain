# Encrypts all markdown files in hubs/ to backups/ using AES
param(
    [System.Security.SecureString]$Password
)
if (-not $Password) {
    $Password = Read-Host -AsSecureString "Enter encryption password"
}
$plain = ConvertFrom-SecureString $Password -AsPlainText
$key = [System.Text.Encoding]::UTF8.GetBytes($plain.PadRight(32).Substring(0, 32))
$hubsPath = Join-Path $PSScriptRoot '..' | Join-Path -ChildPath 'hubs'
$backupPath = Join-Path $PSScriptRoot '..' | Join-Path -ChildPath 'backups'
$files = Get-ChildItem -Path $hubsPath -Recurse -Filter *.md
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.Key = $key
    $aes.GenerateIV()
    $iv = $aes.IV
    $encryptor = $aes.CreateEncryptor()
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($content)
    $enc = $encryptor.TransformFinalBlock($bytes, 0, $bytes.Length)
    $out = $iv + $enc

    # Get relative path from hubs
    $relativePath = $file.FullName.Substring($hubsPath.Length)
    $relativePath = $relativePath -replace '^[\\/]+' , ''  # Remove leading slashes/backslashes
    $encPath = [System.IO.Path]::ChangeExtension($relativePath, '.enc')
    $outFile = Join-Path $backupPath $encPath

    # Ensure target directory exists
    $outDir = Split-Path $outFile -Parent
    if (-not (Test-Path $outDir)) {
        New-Item -ItemType Directory -Path $outDir -Force | Out-Null
    }

    [IO.File]::WriteAllBytes($outFile, $out)
    Write-Host "Encrypted $($file.Name) -> $outFile"
}

# Encrypts all markdown files in hubs/ to backups/ using AES
param(
    [System.Security.SecureString]$Password
)
if (-not $Password) {
    $Password = Read-Host -AsSecureString "Enter encryption password"
}
$plain = ConvertFrom-SecureString $Password -AsPlainText
$key = [System.Text.Encoding]::UTF8.GetBytes($plain.PadRight(32).Substring(0,32))
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
    $outFile = Join-Path $backupPath ("$($file.BaseName).enc")
    [IO.File]::WriteAllBytes($outFile, $out)
    Write-Host "Encrypted $($file.Name) -> $outFile"
}

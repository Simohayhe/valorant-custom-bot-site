# 紹介サイトを web01(自宅Webサーバー)に反映する。
# このフォルダのページ(index.html など)を /var/www/valorant に送るだけ。Caddyの再起動は不要。
# 認証は更新専用のSSH鍵(%USERPROFILE%\.ssh\web01_deploy)。パスワードは使わない。
$ErrorActionPreference = 'Stop'
$key  = Join-Path $env:USERPROFILE '.ssh\web01_deploy'
$dest = 'master@192.168.11.107:/var/www/valorant/'
$skip = @('deploy.ps1', 'deploy.bat', 'README.md')
$files = Get-ChildItem -Path $PSScriptRoot -File | Where-Object { $skip -notcontains $_.Name -and -not $_.Name.StartsWith('.') }
if (-not (Test-Path $key)) { throw "更新用の鍵がありません: $key" }
Write-Output ("送信: " + (($files | ForEach-Object Name) -join ', '))
& scp.exe -i $key -o BatchMode=yes -o StrictHostKeyChecking=accept-new @($files | ForEach-Object FullName) $dest
if ($LASTEXITCODE -ne 0) { throw "送信に失敗しました(終了コード $LASTEXITCODE)" }
Write-Output "反映しました: https://valorant.simohaya.com/"

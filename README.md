# VALORANT カスタムbot 紹介サイト

https://valorant.simohaya.com/

`index.html` 1枚の静的サイト。自宅のWebサーバー(Caddy)で配信している。

## 更新のしかた
1. `index.html` を編集する
2. `deploy.bat` をダブルクリック(またはPowerShellで `.\deploy.ps1`)
   - ページをWebサーバーへ送るだけ。サーバーの再起動は不要で、すぐ反映される
   - 認証は更新専用のSSH鍵(`%USERPROFILE%\.ssh\web01_deploy`)を使う。パスワードは不要
3. 変更を `git commit` / `git push`

## 配信の構成(メモ)
- Webサーバー: Caddy(HTTPS証明書は Let's Encrypt から自動取得・自動更新)
- 公開ポート: 80(httpsへ転送)/ 443(HTTPS・HTTP/3)

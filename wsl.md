## WSL

### WSL(Windows Subsystem for Linux)を有効にする
1. Powershellを管理者で起動する
1. WSLを有効にする
    ```
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    ```
1. Microsoft StoreからUbuntuをインストールする (検索⇒Ubuntu)

### アップデート/アップグレード
```
$ sudo apt -y update
$ sudo apt -y upgrade
```

WSLでやっておくコマンド
```
よく使うフォルダにWSL側からリンクを貼る
ln -s /mnt/c/Users/[User_name]/Downloads ~/Downloads

```

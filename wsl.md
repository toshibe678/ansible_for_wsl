## WSL

### WSL(Windows Subsystem for Linux)を有効にする
Powershellを管理者モードで起動し下記
```
wsl --install
```

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

alternativesのeditorをvimにする
```shell
sudo update-alternatives --config editor
```
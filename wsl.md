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
alternativesのeditorをvimにする
```shell
sudo update-alternatives --config editor
```
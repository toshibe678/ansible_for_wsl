# WSL2 docker

## WSLを有効にする
PowerShellを管理者として実行して下記を行う
```
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

### Linuxディストリビューションのインストール
1. Microsoft Storeを起動する。
1. 検索ボックスにWSLと入力し、Ubuntuをインストールする。
1. Ubuntuを起動し（初回はしばらく待つ）、ユーザー名とパスワードを入力する。※Windowsのユーザ名とパスワードと一致させる必要はない

### WSL1→WSL2への変換
1. 現在のバージョンを確認する。（VERSIONが1になっている）
    ```
    wsl -l -v
    
    NAME      STATE           VERSION
    * Ubuntu    Stopped         1
    ```
1. PowerShellを管理者権限で起動し、以下コマンドを実行してUbuntuをWSL2へ変換する。
    ```
    wsl --set-version Ubuntu 2
    ```
1. 下記コマンドでデフォルトのWSLバージョンを2に設定します。
    ```
    wsl --set-default-version 2
    ```

### Docker Desktop for WSL 2のインストール

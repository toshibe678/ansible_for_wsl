# WSLを最低限使いやすくするAnsible

### `今の所Ubuntuのみに対応`

# 使用法
スタートメニューよりUbuntuを起動し下記コマンドを実行する

`user_nameおよびuser_emailは自分のアドレスに変更すること。`
```
sudo apt update
sudo apt upgrade -y
sudo apt install -y ansible git
git clone https://git.infrastructure.jp/cs/ansible_for_wsl
cd ansible_for_wsl
# user_nameおよびuser_emailは自分のアドレスに変更すること。
ansible-playbook -D -l wsl -i hosts.yml -e user_name=hoge -e user_email=hoge@exmple.com --ask-become-pass all.yml
```

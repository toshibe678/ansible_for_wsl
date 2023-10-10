# WSLを最低限使いやすくするAnsible

### `今の所Ubuntuのみに対応`

# 使用法
スタートメニューよりUbuntuを起動し下記コマンドを実行する

`user_nameおよびuser_emailは自分のアドレスに変更すること。`
```
sudo apt update && sudo apt upgrade -y
sudo apt install -y ansible git
git clone https://github.com/toshi-click/ansible_for_wsl.git
cd ansible_for_wsl
ansible-galaxy install -r requirements.yml -p roles --force
# 新しいiptablesは使えないから、iptables-legacyに切り替えないとDocker起動エラーになっちゃう
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
# user_nameおよびuser_emailは自分のアドレスに変更すること。
ansible-playbook -D -l wsl -i hosts.yml -e '{ "user_name": "toshi", "user_email": "toshi@toshi.click" }' --ask-become-pass  all.yml
```

# 秘密鍵は自分で置いてね
* ローカルネットワークなどに接続するSSH鍵
    * /home/user_name/.ssh/id_rsa
* GitHubとGitLabへsshで接続する際の鍵
    * /home/user_name/.ssh/gitkey


# docker起動しないときにdebug
```bash
dockerd --debug
```

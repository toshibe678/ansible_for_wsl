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
# user_nameおよびuser_emailは自分のアドレスに変更すること。
ansible-playbook -D -l wsl -i hosts.yml -e '{ "user_name": "toshi", "user_email": "toshi@toshi.click", "dns_servers":['172.16.177.100', '8.8.8.8'] }' --ask-become-pass all.yml
```

# 秘密鍵は自分で置いてね
* ローカルネットワークなどに接続するSSH鍵
    * /home/user_name/.ssh/id_rsa
* GitHubとGitLabへsshで接続する際の鍵
    * /home/user_name/.ssh/gitkey

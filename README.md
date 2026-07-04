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
ansible-playbook -D -l wsl -i hosts.yml -e '{ "user_name": "toshi", "user_email": "toshi@toshi.click" }' --ask-become-pass --ask-vault-password all.yml
# 2回目以降
ansible-playbook -D -l wsl -i hosts.yml -e '{ "user_name": "toshi", "user_email": "toshi@toshi.click" }' --ask-vault-password all.yml
```

## develop-setting 連携について

- この Playbook は実行時に `{{ user_name }}` のホーム配下へ `develop-setting` を clone / update して参照します。  
    参照先: `/home/{{ user_name }}/git/develop-setting`
- WSL 側の Claude Code 開発環境設定（`~/.claude/CLAUDE.md`、`~/.claude/settings.json`、Claude Code導入・更新設定など）は `develop-setting` role 側を正として適用します。
- Windows 側の `.claude/` への配置（`/mnt/c/Users/{{ win_user_name }}/.claude/`）は `win.yml` で継続しつつ、テンプレートは `develop-setting/templates/` を参照します。

# 秘密鍵は自分で置いてね
* ローカルネットワークなどに接続するSSH鍵
    * /home/user_name/.ssh/id_rsa
* GitHubとGitLabへsshで接続する際の鍵
    * /home/user_name/.ssh/gitkey


# docker起動しないときにdebug
```bash
dockerd --debug
```

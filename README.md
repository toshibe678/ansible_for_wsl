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
ansible-galaxy install -r requirements.yml --force
ansible-galaxy collection install -r requirements.yml --force

# user_nameおよびuser_emailは自分のアドレスに変更すること。
ansible-playbook -D -l wsl -i hosts.yml -e '{ "user_name": "toshi", "user_email": "toshi@toshi.click" }' --ask-become-pass --ask-vault-password all.yml
# 2回目以降
ansible-playbook -D -l wsl -i hosts.yml -e '{ "user_name": "toshi", "user_email": "toshi@toshi.click" }' --ask-vault-password all.yml
# vault passファイルを使用する場合
ansible-playbook -D -l wsl -i hosts.yml -e '{ "user_name": "toshi", "user_email": "toshi@toshi.click" }' --vault-password-file ~/.ssh/.ansible_vault_pass all.yml

```

## 動作環境

ansible-core 2.16 以上（`develop-setting` の最小の版と同じ）。Ubuntu 24.04 / 26.04。collection は `community.general` と `ansible.posix`（実行時間の記録に使う）です。

## develop-setting への集約

WSL 固有の設定（ロケール、タイムゾーン、sudoers、Windows 連携、docker）だけをこのリポジトリに残し、
開発言語・ツール・共通CLI・ホーム直下の設定・AI設定・個人リポジトリの clone は `develop-setting`（`develop_setting` role）を正としています。
`develop.yml` が `develop_setting_profile: workstation`（全グループ有効）で呼び出します。
`.aws/config` と SSH 鍵（Vault 暗号化済み）は、`develop.yml` が絶対パスで role に渡します。

### 取り込み前の確認（`develop-setting` の変更を `main` へ入れる前）

`requirements.yml` は `develop-setting` の `main` の最新を取得します。変更を取り込む前に、作業ブランチを取得した状態で差分を確認します。

```bash
make check-branch BRANCH=<develop-setting の作業ブランチ> VAULT_PASS=~/.ssh/.ansible_vault_pass
```

一時的な requirements ファイルを `$TMPDIR` に作る（コミットしない）ので、リポジトリの `requirements.yml` は変わりません。`--check -D` の出力を残してください。

### 検査

`make lint`（`ansible-playbook --syntax-check` と `ansible-lint`）を push 前に実行してください。CI は `.github/workflows/ansible-lint.yml` です。

### OpenCode（LiteLLM 経由）の設定

`develop.yml` が、OpenCode の接続先（`develop_setting_opencode_base_url`）、モデル一覧、既定モデル、小型モデルを `develop-setting` に渡します。
接続先 URL（`https://llm-proxy.abe365.org/v1`）は仮定で、未確認です。`context` / `output` と既定モデル・小型モデルは仮置きで、実測のあとに差し替えます。

- モデル一覧（`develop_setting_opencode_models` の `id`）は、`infra/service/llm-proxy/config/config.yaml` の `model_name` と一致させる必要があります。片方だけ変えると、OpenCode から存在しないモデルを呼ぶことになります。
- LiteLLM の専用キーは、Vault 暗号化したファイル `templates/home/.config/opencode/litellm.env` を人間が作って渡します。実ファイルはコミットしますが、平文のまま置かないでください。
  中身は `LITELLM_API_KEY=<発行したキー>` の 1 行です。

```bash
ansible-vault create --vault-password-file ~/.ssh/.ansible_vault_pass templates/home/.config/opencode/litellm.env
```

- `ansible-vault view` や `git diff` でキーを画面に出さないでください。`git add` の前に、先頭が `$ANSIBLE_VAULT;` で始まっていることを確認します。

## develop-setting 連携について

- この Playbook は実行時に `{{ user_name }}` のホーム配下へ `develop-setting` を clone / update して参照します。  
    参照先: `/home/{{ user_name }}/git/develop-setting`
- WSL 側の Claude Code 開発環境設定（`~/.claude/CLAUDE.md`、`~/.claude/settings.json`、Claude Code導入・更新設定など）は `develop-setting` role 側を正として適用します。
- Windows 側の `.claude/` への配置（`/mnt/c/Users/{{ win_user_name }}/.claude/`）も、WSL上で実行する `develop-setting` の `windows_from_wsl` モードで適用します。
- そのため、Windows実機のOS判定分岐ではなく、Linux実行中に `/mnt/c/Users/...` へ直接設定を書き込みます。

# 秘密鍵は自分で置いてね
* ローカルネットワークなどに接続するSSH鍵
    * /home/user_name/.ssh/id_rsa
* GitHubとGitLabへsshで接続する際の鍵
    * /home/user_name/.ssh/gitkey


# docker起動しないときにdebug
```bash
dockerd --debug
```

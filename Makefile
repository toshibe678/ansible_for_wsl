.PHONY: lint check-branch

# 検査: 構文検査と ansible-lint
lint:
	ansible-playbook -i hosts.yml --syntax-check all.yml
	ansible-lint -c .ansible-lint all.yml

# 取り込み前の確認: develop-setting の作業ブランチを取得した状態で --check -D を実行する
#   make check-branch BRANCH=<作業ブランチ> VAULT_PASS=~/.ssh/.ansible_vault_pass
# 一時ファイルは TMPDIR に作り、成否にかかわらず削除する。リポジトリの requirements.yml は変更しない。
# 値はシェルの文字列に展開せず、環境変数（$$BRANCH など）で渡す。ブランチ名は使える文字を限定する
BRANCH ?=
VAULT_PASS ?= $(HOME)/.ssh/.ansible_vault_pass
export BRANCH VAULT_PASS

check-branch:
	@test -n "$$BRANCH" || { echo "BRANCH を指定してください (例: make check-branch BRANCH=feature/x)"; exit 1; }
	@printf '%s' "$$BRANCH" | grep -Eq '^[A-Za-z0-9._/-]+$$' || { echo "ブランチ名に使えない文字が含まれています: $$BRANCH"; exit 1; }
	@req="$${TMPDIR:-/tmp}/ansible_for_wsl-requirements-$$(id -u).yml"; \
	trap 'rm -f "$$req"' EXIT; \
	sed "s|^\(    src: .*\)\$$|\1\n    version: $$BRANCH|" requirements.yml > "$$req" && \
	ansible-galaxy collection install -r "$$req" && \
	ansible-galaxy install -r "$$req" --force && \
	ansible-playbook -D -C -l wsl -i hosts.yml --vault-password-file "$$VAULT_PASS" \
	  -e "{ \"user_name\": \"$$(id -un)\", \"user_email\": \"toshi@toshi.click\" }" --ask-become-pass all.yml

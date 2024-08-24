.PHONY: init exec

# makefile内のすべてのコマンドが単一のシェルスクリプトで実行されるようになるおまじない
.ONESHELL:

init:
	@sudo apt update
	@sudo apt upgrade -y
	@sudo apt install -y ansible git
	@exec

exec:
	@ansible-galaxy install -r requirements.yml -p roles --force
	@ansible-playbook -D -l wsl -i hosts.yml -e '{ "user_name": "toshi", "user_email": "toshi@toshi.click" }' --ask-become-pass  all.yml
.DEFAULT_GOAL := help

help: ## このヘルプメッセージを表示
	@echo "利用可能なコマンド:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo ""

mac-setting: ## Mac環境のセットアップを実行（Homebrew、シンボリックリンク、Vimテーマなど）
	zsh ctl_mac.sh

symbolic-link: ## ドットファイルをシンボリックリンクで配置（配置方式はこちらが正）
	zsh cmd/setup_synbolic_links.sh $(PWD)

brew-bundle: ## Brewfileのパッケージをインストール
	brew bundle --file=$(PWD)/Brewfile

aqua-install: ## aqua.yamlのCLIツールをインストール
	aqua install -a

# --- chezmoi ---
# 注意: このリポジトリのドットファイルは .zshrc のような "." 始まりの名前で置かれており、
# chezmoiはソースディレクトリ内の "." 始まりエントリを無視する。そのため chezmoi が
# 実際に管理しているのは private_dot_config 配下（~/.config/borders/bordersrc）のみ。
# 誤って README.md などが $HOME にコピーされないよう .chezmoiignore を用意している。
chezmoi-diff: ## chezmoiで変更内容を確認
	CHEZMOI_SOURCE_DIR=$(PWD) chezmoi diff

chezmoi-status: ## chezmoiで管理状態を確認
	CHEZMOI_SOURCE_DIR=$(PWD) chezmoi status

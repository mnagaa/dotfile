.DEFAULT_GOAL := help

help: ## このヘルプメッセージを表示
	@echo "利用可能なコマンド:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo ""

mac-setting: ## Mac環境のセットアップを実行（Homebrew、シンボリックリンク、Vimテーマなど）
	zsh ctl_mac.sh

symbolic-link: ## シンボリックリンクのみを設定（chezmoi未使用時）
	bash cmd/setup_synbolic_links.sh

chezmoi-init: ## chezmoiを初期化（リポジトリをソースとして使用）
	CHEZMOI_SOURCE_DIR=$(PWD) chezmoi init --apply

chezmoi-apply: ## chezmoiでドットファイルを適用
	CHEZMOI_SOURCE_DIR=$(PWD) chezmoi apply

chezmoi-diff: ## chezmoiで変更内容を確認
	CHEZMOI_SOURCE_DIR=$(PWD) chezmoi diff

chezmoi-status: ## chezmoiで管理状態を確認
	CHEZMOI_SOURCE_DIR=$(PWD) chezmoi status

borders-reload: ## JankyBordersの設定をリロード
	@if [ -f ~/.config/borders/bordersrc ]; then \
		echo "JankyBordersの設定をリロードしています..."; \
		bash ~/.config/borders/bordersrc; \
		echo "リロード完了"; \
	else \
		echo "エラー: ~/.config/borders/bordersrc が見つかりません"; \
		echo "先に 'make symbolic-link' を実行してください"; \
		exit 1; \
	fi

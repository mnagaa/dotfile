.DEFAULT_GOAL := help

help: ## このヘルプメッセージを表示
	@echo "利用可能なコマンド:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo ""

mac-setting: ## Mac環境のセットアップを実行（Homebrew、シンボリックリンク、Vimテーマなど）
	zsh ctl_mac.sh

linux-setting: ## Linux環境のセットアップを実行
	bash ctl_linux.sh

symbolic-link: ## シンボリックリンクのみを設定
	bash cmd/setup_synbolic_links.sh

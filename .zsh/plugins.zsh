# ==========================================
# zplug プラグインマネージャー設定
# ==========================================

# zplugが無ければインストール
# $ zplug install
if [[ ! -d $HOME/.zplug ]];then
  git clone https://github.com/zplug/zplug $HOME/dotfile/.zplug
  ln -s ~/dotfile/.zplug ~/.zplug
fi

# zplugのキャッシュを有効化（高速化）
export ZPLUG_CACHE_DIR="$HOME/.cache/zplug"

source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# theme: https://github.com/unixorn/awesome-zsh-plugins#themes
# theme (https://github.com/sindresorhus/pure#zplug)

zplug "mafredri/zsh-async"

# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
# 遅延読み込みで高速化（deferオプションで読み込みを遅延）
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# history関係
zplug "zsh-users/zsh-history-substring-search", defer:3

# タイプ補完
zplug "zsh-users/zsh-autosuggestions", defer:2

# zsh-completionsは遅延読み込み（補完が必要になったときに読み込む）
zplug "zsh-users/zsh-completions"

# zsh-256colorは不要な可能性があるため、コメントアウト
# zplug "chrissicool/zsh-256color"

# https://github.com/ryanoasis/nerd-fonts
# brew tap homebrew/cask-fonts
zplug romkatv/powerlevel10k, as:theme, depth:1

# Install plugins if there are plugins that have not been installed
# 高速化のため、キャッシュを活用
if ! zplug check --quiet; then
    # 非対話モードで自動インストール（起動時の遅延を削減）
    zplug install
fi
# Then, source plugins and add commands to $PATH
# 高速化のため、キャッシュを活用
zplug load --verbose 2>/dev/null || zplug load

# ==========================================
# zsh-autosuggestionsの設定最適化
# ==========================================
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
# 非同期で提案を取得（高速化）
ZSH_AUTOSUGGEST_USE_ASYNC=true
# 提案の最大長を制限（パフォーマンス向上）
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# ==========================================
# zsh-history-substring-searchのキーバインド設定
# ==========================================
# 上下矢印キーで履歴検索
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# vimモードでも動作するように設定
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


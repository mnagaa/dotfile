# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ==========================================
# 1) .zshenv
# 2) .zprofile
# 3) .zshrc  *** this file
# 4) .zlogin
#
# $ zcompile ~/.zshrc
# でコンパイルしておくと読み込むときに時間がかからなくなるので
# scriptが長くなったときに実行する
# ==========================================

# 自動compile設定
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

# ==========================================
# 設定ファイルの読み込み
# ==========================================

# zsh設定ファイルのディレクトリ
ZSH_CONFIG_DIR="${ZDOTDIR:-$HOME}/.zsh"

# 設定ファイルを安全に読み込む関数
_load_zsh_config() {
  local config_file="$ZSH_CONFIG_DIR/$1"
  if [[ -f "$config_file" ]]; then
    source "$config_file"
  else
    # デバッグモード時のみ警告を表示
    [[ -n "$ZSH_DEBUG" ]] && echo "[WARN] Config file not found: $config_file" >&2
  fi
}

# 設定ファイルを順番に読み込み
_load_zsh_config "plugins.zsh"    # プラグイン設定（最初に読み込む）
_load_zsh_config "options.zsh"    # zshオプション設定
_load_zsh_config "fzf.zsh"        # fzf設定
_load_zsh_config "git.zsh"        # Git関連設定
_load_zsh_config "aliases.zsh"    # エイリアス設定
_load_zsh_config "functions.zsh"  # 関数定義
_load_zsh_config "env.zsh"        # 環境変数設定（最後に読み込む）

# ==========================================
# その他の設定
# ==========================================

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

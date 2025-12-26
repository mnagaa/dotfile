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

# ==========================================
# 設定ファイルの読み込み
# ==========================================

# zsh設定ファイルのディレクトリ
ZSH_CONFIG_DIR="${ZDOTDIR:-$HOME}/.zsh"

# キャッシュディレクトリの作成（高速化のため）
[[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ]] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

# 自動compile設定（高速化のため）
# .zshrcと.zsh/*.zshファイルをコンパイルして読み込み速度を向上
_zcompile_zsh_config() {
  local config_file="$1"
  local compiled_file="${config_file}.zwc"

  # ソースファイルがコンパイル済みファイルより新しい場合、再コンパイル
  if [[ ! -f "$compiled_file" ]] || [[ "$config_file" -nt "$compiled_file" ]]; then
    zcompile "$config_file" 2>/dev/null
  fi
}

# .zshrcをコンパイル
_zcompile_zsh_config ~/.zshrc

# .zshディレクトリ内の設定ファイルもコンパイル
if [[ -d "$ZSH_CONFIG_DIR" ]]; then
  for config_file in "$ZSH_CONFIG_DIR"/*.zsh; do
    [[ -f "$config_file" ]] && _zcompile_zsh_config "$config_file"
  done
fi

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

# ==========================================
# ローカル設定ファイルの読み込み（最後に読み込む）
# ==========================================
# ユーザー固有の設定をここに記述できます
# このファイルはgit管理外にすることを推奨します
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

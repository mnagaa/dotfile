# ==========================================
# 環境変数設定
# ==========================================

# Homebrewのパスを動的に検出（Intel Mac / Apple Silicon Mac対応）
# キャッシュを活用して高速化
if [[ -z "$HOMEBREW_PREFIX" ]]; then
  if [[ -d /opt/homebrew ]]; then
    # Apple Silicon Mac
    HOMEBREW_PREFIX="/opt/homebrew"
  elif [[ -d /usr/local/Homebrew ]]; then
    # Intel Mac
    HOMEBREW_PREFIX="/usr/local"
  else
    # Homebrewがインストールされていない場合、brewコマンドから検出
    # この処理は重いので、最後の手段として使用
    if command -v brew >/dev/null 2>&1; then
      HOMEBREW_PREFIX=$(brew --prefix 2>/dev/null)
    fi
  fi
  export HOMEBREW_PREFIX
fi

# z command（遅延読み込みで高速化）
# zコマンドは実際に使用するときに読み込むようにする
if [[ -n "$HOMEBREW_PREFIX" && -f "$HOMEBREW_PREFIX/etc/profile.d/z.sh" ]]; then
  # zコマンドが存在しない場合のみ読み込む（既に読み込まれている場合はスキップ）
  if ! command -v z >/dev/null 2>&1; then
    source "$HOMEBREW_PREFIX/etc/profile.d/z.sh"
  fi
fi

# go setting
export GOPATH=$HOME/go
# PATHの重複を防ぐ（typeset -U path PATHが.zshenvで設定されているため、直接path配列に追加）
[[ -d "$GOPATH/bin" ]] && path=($GOPATH/bin $path)

# AWS setting
export AWS_REGION="ap-northeast-1"

# Terraform補完設定
if [[ -n "$HOMEBREW_PREFIX" && -f "$HOMEBREW_PREFIX/bin/terraform" ]]; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C "$HOMEBREW_PREFIX/bin/terraform" terraform
fi

# nodenv設定
if command -v nodenv >/dev/null 2>&1; then
  eval "$(nodenv init -)"
fi

# aqua設定
# Powerlevel10kのinstant promptとの競合を避けるため、ログ出力を抑制
if command -v aqua >/dev/null 2>&1; then
  # aquaのログレベルをerrorに設定（infoレベルのログを抑制）
  # 注意: AQUA_LOG_LEVELが既に設定されている場合はその値を使用
  if [[ -z "$AQUA_LOG_LEVEL" ]]; then
    export AQUA_LOG_LEVEL="error"
  fi
  # 環境変数を設定してからaqua initを実行
  # aquaのログメッセージ（time=で始まる行）をフィルタリングしてからeval
  # 標準出力と標準エラー出力の両方を抑制（instant promptの警告を防ぐため）
  _aqua_init_output=$(AQUA_LOG_LEVEL="$AQUA_LOG_LEVEL" aqua init zsh 2>&1 | grep -v '^time=' || true)
  if [[ -n "$_aqua_init_output" ]]; then
    eval "$_aqua_init_output" 2>/dev/null || eval "$_aqua_init_output"
  else
    # フィルタリングで何も残らなかった場合、通常の方法で実行
    eval "$(aqua init zsh 2>&1 | grep -v '^time=')" 2>/dev/null || eval "$(aqua init zsh 2>/dev/null)"
  fi
  unset _aqua_init_output
fi

# direnv設定
# direnvがインストールされている場合、自動的に環境変数を設定
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# Google Cloud SDK設定（パスを動的に検出）
if [[ -d "$HOME/google-cloud-sdk" ]]; then
  # ホームディレクトリ直下の場合
  GCLOUD_SDK="$HOME/google-cloud-sdk"
elif [[ -d "$HOME/Downloads/google-cloud-sdk" ]]; then
  # Downloadsディレクトリの場合
  GCLOUD_SDK="$HOME/Downloads/google-cloud-sdk"
elif [[ -d "/usr/local/google-cloud-sdk" ]]; then
  # システムディレクトリの場合
  GCLOUD_SDK="/usr/local/google-cloud-sdk"
fi

if [[ -n "$GCLOUD_SDK" ]]; then
  if [[ -f "$GCLOUD_SDK/path.zsh.inc" ]]; then
    source "$GCLOUD_SDK/path.zsh.inc"
  fi
  if [[ -f "$GCLOUD_SDK/completion.zsh.inc" ]]; then
    source "$GCLOUD_SDK/completion.zsh.inc"
  fi
fi

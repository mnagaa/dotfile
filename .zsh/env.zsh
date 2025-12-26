# ==========================================
# 環境変数設定
# ==========================================

# Homebrewのパスを動的に検出（Intel Mac / Apple Silicon Mac対応）
if [[ -d /opt/homebrew ]]; then
  # Apple Silicon Mac
  HOMEBREW_PREFIX="/opt/homebrew"
elif [[ -d /usr/local/Homebrew ]]; then
  # Intel Mac
  HOMEBREW_PREFIX="/usr/local"
else
  # Homebrewがインストールされていない場合、brewコマンドから検出
  if command -v brew >/dev/null 2>&1; then
    HOMEBREW_PREFIX=$(brew --prefix)
  fi
fi

# z command
if [[ -n "$HOMEBREW_PREFIX" && -f "$HOMEBREW_PREFIX/etc/profile.d/z.sh" ]]; then
  source "$HOMEBREW_PREFIX/etc/profile.d/z.sh"
fi

# go setting
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

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


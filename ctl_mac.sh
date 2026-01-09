#!/bin/zsh
set -euo pipefail

# スクリプトのディレクトリを取得（シンボリックリンク経由でも正しく動作）
SCRIPT_DIR="$(cd "$(dirname "${(%):-%x}")" && pwd)"
DOTFILE_DIR="$SCRIPT_DIR"

# カラー出力用の変数
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ログ関数
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# エラーハンドリング
handle_error() {
    log_error "エラーが発生しました: 行 $1"
    exit 1
}

trap 'handle_error $LINENO' ERR

log_info "dotfileのセットアップを開始します"
log_info "dotfileディレクトリ: $DOTFILE_DIR"

# Homebrewのインストール確認とインストール
if ! command -v brew &> /dev/null; then
    log_info "Homebrewをインストールします"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Apple Silicon Macの場合、パスを追加
    if [[ $(uname -m) == "arm64" ]]; then
        log_info "Apple Silicon Mac用のパスを追加します"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    log_info "Homebrewは既にインストールされています"
fi

# brew bundleの実行
log_info "brew bundleを実行します"
cd "$DOTFILE_DIR"
if brew bundle; then
    log_info "brew bundleが完了しました"
else
    log_warn "brew bundleでエラーが発生しましたが、処理を続行します"
    log_warn "不足しているパッケージがある場合は、後で手動でインストールしてください"
fi

# aquaのパッケージインストール
log_info "aquaでパッケージをインストールします"
cd "$DOTFILE_DIR"
if command -v aqua >/dev/null 2>&1; then
    if aqua install -a; then
        log_info "aquaのパッケージインストールが完了しました"
    else
        log_warn "aquaのパッケージインストールでエラーが発生しましたが、処理を続行します"
    fi
else
    log_warn "aquaがインストールされていません。brew bundleでaquaがインストールされていることを確認してください"
fi

# Git補完スクリプトのダウンロード
ZSH_DIR="$DOTFILE_DIR/.zsh"
if [ ! -d "$ZSH_DIR" ]; then
    log_info "Git補完スクリプトをダウンロードします"
    mkdir -p "$ZSH_DIR"
    cd "$ZSH_DIR"
    curl -fsSL -o git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
    curl -fsSL -o git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    curl -fsSL -o _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
    log_info "Git補完スクリプトのダウンロードが完了しました"
else
    log_info "Git補完スクリプトは既に存在します（スキップ）"
fi

# シンボリックリンクの設定
log_info "シンボリックリンクを設定します"
bash "$DOTFILE_DIR/cmd/setup_synbolic_links.sh" "$DOTFILE_DIR"

# Vimのmolokaiテーマのインストール
log_info "Vimのmolokaiテーマをセットアップします"
VIM_COLORS_DIR="$HOME/.vim/colors"
if [ ! -f "$VIM_COLORS_DIR/molokai.vim" ]; then
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    git clone --depth 1 https://github.com/tomasr/molokai.git
    mkdir -p "$VIM_COLORS_DIR"
    cp molokai/colors/molokai.vim "$VIM_COLORS_DIR/"
    rm -rf "$TEMP_DIR"
    log_info "molokaiテーマのインストールが完了しました"
else
    log_info "molokaiテーマは既にインストールされています（スキップ）"
fi

# nodenvのセットアップ
log_info "nodenvをセットアップします"
if [ ! -d "$HOME/.nodenv" ]; then
    git clone https://github.com/nodenv/nodenv.git "$HOME/.nodenv"

    # nodenv-buildプラグインのインストール
    mkdir -p "$HOME/.nodenv/plugins"
    if [ ! -d "$HOME/.nodenv/plugins/node-build" ]; then
        git clone https://github.com/nodenv/node-build.git "$HOME/.nodenv/plugins/node-build"
    fi

    log_info "nodenvのインストールが完了しました"
    log_warn "nodenvを使用するには、シェル設定に以下を追加してください:"
    log_warn "  export PATH=\"\$HOME/.nodenv/bin:\$PATH\""
    log_warn "  eval \"\$(nodenv init - zsh)\""
else
    log_info "nodenvは既にインストールされています（スキップ）"
fi

log_info "dotfileのセットアップが完了しました！"

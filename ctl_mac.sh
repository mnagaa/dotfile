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

    # このスクリプト内でbrewを使えるようにする
    # （シェル起動時のPATH設定は .zprofile 側で brew shellenv を評価しているため追記不要）
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
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
# 注意: .zsh ディレクトリ自体はリポジトリに含まれるため、ファイル単位で存在確認する
ZSH_DIR="$DOTFILE_DIR/.zsh"
mkdir -p "$ZSH_DIR"
cd "$ZSH_DIR"
GIT_COMPLETION_BASE="https://raw.githubusercontent.com/git/git/master/contrib/completion"
for pair in "git-prompt.sh:git-prompt.sh" "git-completion.bash:git-completion.bash" "_git:git-completion.zsh"; do
    dest="${pair%%:*}"
    src="${pair##*:}"
    if [ -f "$dest" ]; then
        log_info "Git補完スクリプトは既に存在します: $dest（スキップ）"
    else
        log_info "Git補完スクリプトをダウンロードします: $dest"
        curl -fsSL -o "$dest" "$GIT_COMPLETION_BASE/$src" \
            || log_warn "ダウンロードに失敗しました: $dest（スキップ）"
    fi
done

# ドットファイルの配置（シンボリックリンク方式）
#
# 以前はここで chezmoi apply を実行していたが、chezmoi はソースディレクトリ内の
# "." 始まりのエントリを無視する仕様のため、このリポジトリの .zshrc / .zshenv などは
# 一切適用されず、代わりに README.md や Makefile が $HOME にコピーされてしまっていた。
# chezmoi で管理するには dot_zshrc のようなリネームが必要なため、
# 現状はシンボリックリンク方式を正とする。
log_info "ドットファイルをシンボリックリンクで配置します"
zsh "$DOTFILE_DIR/cmd/setup_synbolic_links.sh" "$DOTFILE_DIR"
log_info "ドットファイルの配置が完了しました"

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

# nodenvの確認
# 以前はここで git clone していたが、Brewfile に nodenv / node-build があるため
# ~/.nodenv に二重インストールされ、$HOME/.nodenv/bin が PATH 上で Homebrew 版を
# 隠してしまっていた（brew upgrade でも更新されない）。インストールは Brewfile に任せる。
log_info "nodenvを確認します"
if command -v nodenv >/dev/null 2>&1; then
    log_info "nodenv: $(command -v nodenv)"
    if [ -d "$HOME/.nodenv/bin" ]; then
        log_warn "$HOME/.nodenv にgit clone版のnodenvが残っています"
        log_warn "Homebrew版を使うため、不要であれば $HOME/.nodenv/bin と plugins を削除してください"
    fi
else
    log_warn "nodenvがインストールされていません（brew bundleが失敗している可能性があります）"
fi

log_info "dotfileのセットアップが完了しました！"

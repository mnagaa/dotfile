#!/bin/zsh
set -euo pipefail

# 引数からdotfileディレクトリを取得
if [ $# -eq 0 ]; then
    DOTFILE_DIR="$PWD"
else
    DOTFILE_DIR="$1"
fi

# カラー出力用の変数
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

# バックアップディレクトリ
BACKUP_DIR="$HOME/.dotfile_backup_$(date +%Y%m%d_%H%M%S)"

# シンボリックリンクを設定する関数
setup_symbolic_link(){
    local target_file="$1"
    local source_path="$DOTFILE_DIR/$target_file"
    local target_path="$HOME/$target_file"

    # ソースファイルの存在確認
    if [ ! -e "$source_path" ]; then
        log_warn "ソースファイルが存在しません: $source_path（スキップ）"
        return 0
    fi

    # 既存のファイル/リンク/ディレクトリの処理
    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        # バックアップディレクトリを作成
        mkdir -p "$BACKUP_DIR"

        # 既存のシンボリックリンクを削除
        if [ -L "$target_path" ]; then
            log_info "既存のシンボリックリンクを削除: $target_path"
            rm "$target_path"
        # 既存のファイル/ディレクトリをバックアップ
        elif [ -e "$target_path" ]; then
            log_warn "既存のファイル/ディレクトリをバックアップ: $target_path -> $BACKUP_DIR/"
            mv "$target_path" "$BACKUP_DIR/"
        fi
    fi

    # シンボリックリンクを作成
    log_info "シンボリックリンクを作成: $target_path -> $source_path"
    ln -s "$source_path" "$target_path"
}

cd "$DOTFILE_DIR"

log_info "dotfileディレクトリ: $DOTFILE_DIR"

# zsh関連のシンボリックリンク
log_info "zsh関連のシンボリックリンクを設定します"
setup_symbolic_link .zsh
setup_symbolic_link .zshrc
setup_symbolic_link .zshenv
setup_symbolic_link .zprofile
setup_symbolic_link .p10k.zsh
log_info "zsh関連のシンボリックリンクの設定が完了しました"

# git関連のシンボリックリンク
log_info "git関連のシンボリックリンクを設定します"
setup_symbolic_link .gitconfig
log_info "git関連のシンボリックリンクの設定が完了しました"

# vim関連のシンボリックリンク
log_info "vim関連のシンボリックリンクを設定します"
setup_symbolic_link .vim
setup_symbolic_link .vimrc

# .ideavimrcのシンボリックリンク
if [ -L "$HOME/.ideavimrc" ]; then
    log_info "既存の.ideavimrcシンボリックリンクを削除"
    rm "$HOME/.ideavimrc"
elif [ -e "$HOME/.ideavimrc" ]; then
    mkdir -p "$BACKUP_DIR"
    log_warn "既存の.ideavimrcをバックアップ: $BACKUP_DIR/"
    mv "$HOME/.ideavimrc" "$BACKUP_DIR/"
fi
log_info "シンボリックリンクを作成: $HOME/.ideavimrc -> $HOME/.vimrc"
ln -s "$HOME/.vimrc" "$HOME/.ideavimrc"
log_info "vim関連のシンボリックリンクの設定が完了しました"

if [ -d "$BACKUP_DIR" ]; then
    log_warn "バックアップは以下のディレクトリに保存されました: $BACKUP_DIR"
fi

log_info "すべてのシンボリックリンクの設定が完了しました"


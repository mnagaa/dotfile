#!/bin/zsh
set -euo pipefail

# JankyBordersの設定をリロードするスクリプト

BORDERS_CONFIG_FILE="$HOME/.config/borders/bordersrc"

if [ ! -f "$BORDERS_CONFIG_FILE" ]; then
    echo "エラー: $BORDERS_CONFIG_FILE が見つかりません" >&2
    echo "先にシンボリックリンクを設定してください: make symbolic-link" >&2
    exit 1
fi

echo "JankyBordersの設定をリロードしています..."
bash "$BORDERS_CONFIG_FILE"
echo "リロード完了"

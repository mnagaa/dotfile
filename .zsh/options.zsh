# ==========================================
# zsh オプション設定
# ==========================================

# share history when opening multi-prompt
setopt share_history
setopt hist_ignore_all_dups  # 重複するコマンドのhistory削除
setopt print_eight_bit  # 日本語ファイル名を表示可能にする
setopt auto_cd  # cdなしでディレクトリ移動
setopt no_beep  # ビープ音の停止
setopt nolistbeep  # ビープ音の停止(補完時)
setopt auto_pushd  # cd -<tab>で以前移動したディレクトリを表示
export LANG=ja_JP.UTF-8  # 文字コードの指定
autoload -Uz colors  # 色を使用出来るようにする


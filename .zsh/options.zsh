# ==========================================
# zsh オプション設定
# ==========================================

# ==========================================
# 履歴設定（高速化と最適化）
# ==========================================
HISTFILE=~/.zsh_history
HISTSIZE=10000      # メモリ内に保存する履歴の数
SAVEHIST=10000      # ファイルに保存する履歴の数

# share history when opening multi-prompt
setopt share_history
setopt hist_ignore_all_dups  # 重複するコマンドのhistory削除
setopt hist_ignore_space      # スペースで始まるコマンドを履歴に残さない
setopt hist_reduce_blanks     # 余分な空白を削除して履歴に保存
setopt hist_verify            # 履歴展開時にコマンドを実行前に確認
setopt append_history         # 履歴を追加（上書きしない）
setopt inc_append_history     # 履歴を即座に追加（高速化）

# ==========================================
# その他のオプション設定
# ==========================================
setopt print_eight_bit  # 日本語ファイル名を表示可能にする
setopt auto_cd  # cdなしでディレクトリ移動
setopt no_beep  # ビープ音の停止
setopt nolistbeep  # ビープ音の停止(補完時)
setopt auto_pushd  # cd -<tab>で以前移動したディレクトリを表示
setopt pushd_ignore_dups  # ディレクトリスタックに重複を追加しない

# 補完の高速化オプション
setopt complete_in_word  # 単語の途中でも補完
setopt always_to_end     # 補完時にカーソルを末尾に移動
setopt list_ambiguous     # 曖昧な補完でもリスト表示

# その他の高速化オプション
setopt extended_glob      # 拡張グロブを有効化（高速なパス展開）
setopt no_flow_control    # Ctrl+S/Ctrl+Qのフロー制御を無効化（高速化）
setopt no_clobber         # リダイレクトでの上書きを防ぐ（安全性）

export LANG=ja_JP.UTF-8  # 文字コードの指定
autoload -Uz colors  # 色を使用出来るようにする


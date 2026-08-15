#======================================
# setting path

# Homebrew
# brew shellenv を使うと PATH の先頭に追加され、MANPATH/INFOPATH や
# HOMEBREW_PREFIX などもまとめて設定される。
# （PATH の末尾に追記すると /usr/bin の古いツールが優先されてしまう）
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# nodebrew（インストールされている場合のみ）
[ -d "$HOME/.nodebrew/current/bin" ] && export PATH="$HOME/.nodebrew/current/bin:$PATH"

# nodenv（PATH のみ。init は .zsh/env.zsh 側で行う）
[ -d "$HOME/.nodenv/bin" ] && export PATH="$HOME/.nodenv/bin:$PATH"

if [ -n "$HOMEBREW_PREFIX" ]; then
  export CFLAGS="-I$HOMEBREW_PREFIX/include"
  export LDFLAGS="-L$HOMEBREW_PREFIX/lib"
fi

# マシン固有の設定（git管理外）
[ -f "$HOME/.zprofile.local" ] && source "$HOME/.zprofile.local"

#======================================
# setting path
export PATH="$PATH:/opt/homebrew/bin/"
export PATH="$PATH:$HOME/.nodebrew/current/bin"

# setup nodeenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init - --no-rehash)"

export CFLAGS="-I/opt/homebrew/include"
export LDFLAGS="-L/opt/homebrew/lib"

#======================================
# setting path
export PATH="$PATH:/opt/homebrew/bin/"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.nodebrew/current/bin"

# setup nodeenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init - --no-rehash)"

# setup python
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
alias python='python3'
export POETRY_PYTHON_PATH=$(which python3)

# setup poetry
export PATH="$HOME/.poetry/bin:$PATH"

export CFLAGS="-I/opt/homebrew/include"
export LDFLAGS="-L/opt/homebrew/lib"

#======================================
# setting path
export PATH="$PATH:/opt/homebrew/bin/"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$HOME/.nodebrew/current/bin:$PATH"

# docker with lima
# https://zenn.dev/matsukaz/articles/31bc31ff1c54b4
# export DOCKER_HOST=unix://$HOME/.lima/lima/sock/docker.sock

# setup pyenv
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PYENV_ROOT="${HOME}/.pyenv"
export PATH=${PYENV_ROOT}/bin:$PATH
eval "$(pyenv init --path)"

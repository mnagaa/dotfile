# ==========================================
# zplug プラグインマネージャー設定
# ==========================================

# zplugが無ければインストール
# $ zplug install
if [[ ! -d $HOME/.zplug ]];then
  git clone https://github.com/zplug/zplug $HOME/dotfile/.zplug
  ln -s ~/dotfile/.zplug ~/.zplug
fi
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# theme: https://github.com/unixorn/awesome-zsh-plugins#themes
# theme (https://github.com/sindresorhus/pure#zplug)

zplug "mafredri/zsh-async"

# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting"
# history関係
zplug "zsh-users/zsh-history-substring-search"
# タイプ補完
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"


# https://github.com/ryanoasis/nerd-fonts
# brew tap homebrew/cask-fonts
zplug romkatv/powerlevel10k, as:theme, depth:1

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    # if read -q; then
        echo; zplug install
    # fi
fi
# Then, source plugins and add commands to $PATH
zplug load

# zsh-autosuggestionsのハイライトスタイル設定
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'


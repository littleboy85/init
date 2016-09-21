export ZPLUG_HOME=~/.zplug
if [[ ! -d $ZPLUG_HOME ]]; then
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
source $ZPLUG_HOME/init.zsh 

export TERM="xterm-256color"
export PATH=${HOME}/bin:/usr/local/bin:${PATH}
export ZSH=$HOME/.oh-my-zsh
export REACT_EDITOR=nvim
export EDITOR=nvim

export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh" --no-use
NODE_VERSION=`nvm version node`
export PATH="${PATH}:${NVM_DIR}/versions/node/${NODE_VERSION}/bin"
autoload -Uz colors; colors
autoload -Uz is-at-least; is-at-least
setopt prompt_subst

zplug "robbyrussell/oh-my-zsh", use:oh-my-zsh.sh
zplug "mafredri/zsh-async", on:sindresorhus/pure
zplug "sindresorhus/pure", nice:10
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/thefuck", from:oh-my-zsh, nice:10
zplug "plugins/autojump", from:oh-my-zsh, nice:10
zplug "plugins/vi-mode", from:oh-my-zsh, nice:10
zplug "plugins/common-aliases", from:oh-my-zsh, nice:10
zplug "plugins/compleat", from:oh-my-zsh, nice:10

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

# https://github.com/p-e-w/maybe

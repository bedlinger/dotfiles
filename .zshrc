export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gruvbox"
SOLARIZED_THEME="dark"

zstyle ':omz:update' mode auto      # update automatically without asking

zstyle ':omz:update' frequency 13

HIST_STAMPS="dd.mm.yyy"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use)

source $ZSH/oh-my-zsh.sh

# User configuration

unalias la
unalias ll
unalias lsa

alias l="eza --long --all"
alias ls="eza"
alias lt="eza --long --tree --level=2"
alias la="eza -a"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

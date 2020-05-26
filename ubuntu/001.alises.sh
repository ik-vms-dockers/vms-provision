#!/bin/sh

echo "Run non priveledged commands"

# set aliases
FILE_ALIASES=~/.bash_aliases
BASH_PROFILE=~/.profile

cat >"${FILE_ALIASES}" <<EOF
alias home="cd ~"
alias k=kubectl
alias ks=kubens
alias s="source ~/.profile"
alias cdtf='cdtfswitch'
alias cdtg='cdtgswitch'
alias tf='terraform'
alias tg='terragrunt'
alias diskusage='df -h'
alias folderusage='du -ch'
alias totalfolderusage='du -sh'

alias creds="aws-vault exec $AWS_PROFILE"
alias zs="source ~/.zshrc"
alias nomore='find ./ -iname .DS_Store -delete'
alias clearhist='echo "" > ~/.zsh_history & exec \$SHELL -l'
alias k=kubectl
alias ks=kubens
alias kd=kubedecode
alias kx=kubectx
alias brewup='brew update && brew upgrade && brew cleanup'
alias ugen='uuidgen | tr "[:upper:]" "[:upper:]"'
alias diskusage="df -h"
alias folderusage="du -ch"
alias totalfolderusage="du -sh"
alias sshl="ssh-add -l -E md5"
EOF

source ${FILE_ALIASES}
source .bashrc
source ${BASH_PROFILE}

# ln -sfn ~/.kubectx/completion/kubens.bash $COMPDIR/kubens
# ln -sfn /home/linuxbrew/.linuxbrew/etc/bash_completion.dh $COMPDIR/kubectx

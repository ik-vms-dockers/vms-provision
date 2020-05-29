#!/bin/sh

export RAW_GITHUB=https://raw.githubusercontent.com
export BASE_URL=${RAW_GITHUB}/ik-vms-dockers/vms-provision

echo "Run in non priveledged mode"

echo 'export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"' >> ~/.bash_profile

BASH_PROFILE=~/.profile
BREW_LINKED_DIR="/home/linuxbrew/.linuxbrew/var/homebrew/linked"

if ! grep -qF "#step1" $BASH_PROFILE;
then {
  yes | sh -c "$(curl -fsSL ${RAW_GITHUB}/Homebrew/install/master/install.sh)"
  yes | sh -c "$(curl -fsSL ${RAW_GITHUB}/warrensbox/terraform-switcher/release/install.sh)"
  COMPDIR=$(pkg-config --variable=completionsdir bash-completion)
  sudo mkdir -p ${BREW_LINKED_DIR}
  sudo chown -R $(whoami) ${BREW_LINKED_DIR}
  echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >>${BASH_PROFILE};
  echo 'PATH=/home/linuxbrew/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby/current/bin:$PATH' >>${BASH_PROFILE};
  echo 'PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH' >>${BASH_PROFILE};
  echo 'PATH=~/.kubectx:$PATH' >>${BASH_PROFILE};
  cat << EOF |

cdtfswitch(){
  builtin cd "$@";
  if [ -f ".tfswitchrc" ]; then
    tfswitch
  fi
}

cdtgswitch(){
  builtin cd "$@";
  cdir=$PWD;
  if [ -f "$cdir/.tgswitchrc" ]; then
    tgswitch
  fi
}

#step1 $(date +%F)

EOF
  awk '{print}' >> $BASH_PROFILE
} fi

source $BASH_PROFILE

if [ ! -f ./Brewfile ]; then
    echo "Brewfile file not found!"
    exit 1
fi

brew doctor
brew bundle --file=/vagrant/cfg/Brewfile -v --describe
brew bundle cleanup --file=/vagrant/cfg/Brewfile --force
brew list

if ! grep -qF "#step2" ${BASH_PROFILE};
then {
  cat << EOF |
source <(kubectl completion bash)
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion
#step2 $(date +%F)
EOF
  awk '{print}' >> ${BASH_PROFILE}
} fi

source ${BASH_PROFILE}

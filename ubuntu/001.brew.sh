#!/bin/sh

: "${BASE_URL}"

export RAW_GITHUB=https://raw.githubusercontent.com

echo "Run in non priveledged mode"

# echo 'export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"' >> ~/.bash_profile

PROFILE=~/.profile
BASH_PROFILE=~/.bash_profile

yes | /bin/bash -c "$(curl -fsSL ${RAW_GITHUB}/Homebrew/install/master/install.sh)"
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
line="eval \$($(brew --prefix)/bin/brew shellenv)"
test -r ~/.bash_profile &&  grep -qF -- "$line" "${BASH_PROFILE}" || echo "$line" >> "${BASH_PROFILE}"
test -r ~/.bash_profile &&  grep -qF -- ". ~/.profile" "${BASH_PROFILE}" || echo ". ~/.profile" >> "${BASH_PROFILE}"

if [ ! -f "${PROFILE}" ]; then
    echo "'${PROFILE}' not found"
    exit 1
else
  grep -qF -- "eval \"\$(direnv hook bash)\"" "${PROFILE}" || echo "eval \"\$(direnv hook bash)\"" >> "${PROFILE}"
  grep -qF -- "$line" "${PROFILE}" || echo "$line" >> "${PROFILE}"
fi

/bin/bash -c "source ${BASH_PROFILE}"

if [ ! -f ~/.Brewfile ]; then
    echo "Brewfile file not found!"
    exit 1
fi

brew doctor
brew bundle --file=~/.Brewfile -v --describe
brew bundle cleanup --file=~/.Brewfile -v --force
brew list

if ! grep -qF "#tools" ${PROFILE}; then
cat << EOF |

#tools ---setup---

cdtfswitch(){
  builtin cd "$@";
  if [ -f ".tfswitchrc" ]; then
    tfswitch
  fi
}

cdtgswitch(){
  builtin cd "$@";
  if [ -f "$PWD/.tgswitchrc" ]; then
    tgswitch
  fi
}

source <(kubectl completion bash)
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion

#tools $(date +%F+%T)

EOF
  awk '{print}' >> ${PROFILE}
fi

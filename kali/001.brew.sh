#!/bin/sh

: ${RUBY_VERSION:-2.7.1}
export RAW_GITHUB=https://raw.githubusercontent.com

echo "Run in non priveledged mode"

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

brew install ruby-build
brew install rbenv
rbenv install ${RUBY_VERSION}
rbenv global ${RUBY_VERSION}

brew bundle --file=~/.Brewfile -v --describe
brew bundle --file=~/.Brewfile.pentest -v --describe
brew list

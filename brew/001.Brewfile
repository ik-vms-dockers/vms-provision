# taps
tap "homebrew/bundle"
tap "homebrew/core"
tap "mveritym/mel"
tap "warrensbox/tap"
tap "derailed/k9s"
tap "homebrew/bundle"
tap "homebrew/cask-cask"
if OS.mac?
tap "homebrew/cask"
tap "homebrew/cask-versions"
end

brew "gcc"
# SSL/TLS cryptography library
brew "openssl"
# Official Amazon AWS command-line interface
brew "awscli"
# CloudFlare's PKI toolkit
brew "cfssl"
# Load/unload environment variables based on $PWD
brew "direnv"
# Editor of encrypted files
brew "sops"
# Lightweight and flexible command-line JSON processor
brew "jq"
# The Kubernetes package manager
brew "kubernetes-helm"
# Terminal-based visual file manager
brew "midnight-commander"
# Python dependency management tool
brew "pipenv"
# Framework for managing multi-language pre-commit hooks
brew "pre-commit"
# Autoformat shell script source code
brew "shfmt"
# Display directories as trees (with optional color/HTML output)
brew "tree"
# Process YAML documents from the CLI
brew "yq"
# Tracks most-used directories to make cd smarter
brew "z"
# Decode all parts of a kubernetes secret, no more copypasting!
brew "mveritym/mel/kubedecode"
brew "kubernetes-cli"
# Tool that can switch between kubectl contexts easily and create aliases
brew "kubectx"
# Terminal multiplexer
brew "tmux"
# The tfswitch command lets you switch between terraform versions.
brew "warrensbox/tap/tfswitch"
# The tgswitch command lets you switch between terragrunt versions.
brew "warrensbox/tap/tgswitch"
if OS.mac?
cask "aws-vault"
else
brew "aws-vault"
end
# Tail multiple Kubernetes pods & their containers
brew "stern"

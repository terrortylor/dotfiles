#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd "${SCRIPT_DIR}" > /dev/null || exit

# shellcheck source=./scripts/common.sh
source ../scripts/common.sh

function install_brew() {
  if grep -q ${1} <<< ${installed_brews}; then
    skip "Skipping ${1}"
  else
    info "Installing ${1}"
    brew install ${1}
  fi
}

installed_brews=$(brew list)

info "General workflow packages"
install_brew neovim
install_brew coreutils
install_brew binutils
install_brew diffutils
install_brew findutils --with-default-names
install_brew gawk
install_brew gnu-sed --with-default-names
install_brew gnu-tar --with-default-names
install_brew gnu-which --with-default-names
install_brew gnutls
install_brew grep --with-default-names
install_brew gzip
install_brew watch
install_brew less
install_brew make
install_brew rsync
install_brew unzip
install_brew pygments
install_brew bitwarden-cli
# install_brew podman
# install_brew podman-compose
install_brew kind
install_brew jq
install_brew yq
install_brew kubernetes-cli
install_brew helm
install_brew tmux
install_brew k9s
install_brew iterm2 --cask
install_brew lazygit
install_brew fd
install_brew fzf
install_brew bat
install_brew ripgrep
# postgres cli tooling
install_brew libpq
install_brew cdktf
install_brew pomatez --cask
# Required for neovim's neorg plugin which uses this for treesitter compilation
install_brew gcc

# Required for patching fonts
brew tap homebrew/cask-fonts
# install_brew homebrew/cask-fonts --cask
install_brew font-hack-nerd-font --cask


popd > /dev/null || exit

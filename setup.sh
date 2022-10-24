#! /bin/bash

#set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source scripts/common.sh

info "Setting up dot files..."

create_dir ~/personal-workspace

if [[ $OSTYPE == 'darwin'* ]]; then
  echo 'macOS'
else
  sh -c bash/setup.sh
fi

sh -c tmux/setup.sh
sh -c git/setup.sh
#sh -c vscode/setup.sh

info "Linking bin directory"
link_file "${SCRIPT_DIR}/bin" ~/.my-bin

info "Linking warpd config"
link_file "${SCRIPT_DIR}/config/warpd" ~/.config/warpd

info "Linking alacritty config"
link_file "${SCRIPT_DIR}/config/alacritty" ~/.config/alacritty

info "Cloning NVIM Config"
clone git@github.com:terrortylor/vim-environment.git ~/personal-workspace/vim-environment
link_file ~/personal-workspace/vim-environment ~/.config/nvim

info "Install some stuff"
if [[ $OSTYPE == 'darwin'* ]]; then
  ./install_packages/brew_install.sh
else
  ./install_packages/apt_install.sh
fi
#./install_packages/work_install.sh
./install_packages/go_packages.sh
./install_packages/npm_packages.sh
./install_packages/pip_packages.sh

info "Linking ideavimrc"
link_file "${SCRIPT_DIR}/ideavim/ideavimrc" ~/.ideavimrc

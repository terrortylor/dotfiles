#! /bin/bash

#set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source scripts/common.sh

info "Setting up dot files..."

create_dir ~/personal-workspace

sh -c bash/setup.sh
sh -c tmux/setup.sh
sh -c git/setup.sh
sh -c vscode/setup.sh

info "Linking bin directory"
link_file "${SCRIPT_DIR}/bin" ~/.bin

info "Cloning NVIM Config"
clone git@github.com:terrortylor/vim-environment.git ~/personal-workspace/vim-environment
link_file ~/personal-workspace/vim-environment ~/.config/nvim

info "Install some stuff"
./install_packages/apt_install.sh
./install_packages/work_install.sh
./install_packages/go_packages.sh
./install_packages/pip_packages.sh

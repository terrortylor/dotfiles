#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd "${SCRIPT_DIR}" > /dev/null || exit


# shellcheck source=./scripts/common.sh
source ../scripts/common.sh

info "Setting up zshrc"
link_file "${SCRIPT_DIR}/zshrc" ~/.zshrc

link_file "${SCRIPT_DIR}/zshrc.d" ~/.zshrc.d

info "Installing plugins"
git clone https://github.com/lukechilds/zsh-nvm $HOME/.oh-my-zsh/custom/plugins/zsh-nvm

popd > /dev/null || exit

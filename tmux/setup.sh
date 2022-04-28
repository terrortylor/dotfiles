#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd ${SCRIPT_DIR} > /dev/null || exit


source ../scripts/common.sh

info "Setting up tmux"

create_dir ~/.tmux/plugins

info "\tCloning plugins"
clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
clone https://github.com/laktak/extrakto ~/.tmux/plugins/extrakto

link_file "${SCRIPT_DIR}/tmux.conf" ~/.tmux.conf

popd > /dev/null || exit

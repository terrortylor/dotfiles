#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd "${SCRIPT_DIR}" > /dev/null || exit

# shellcheck source=./scripts/common.sh
source ../scripts/common.sh

info "Setting up tmux"

create_dir ~/.tmux/plugins

info "\tCloning tmux plugin manager"
clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

link_file "${SCRIPT_DIR}/tmux.conf" ~/.tmux.conf

popd > /dev/null || exit

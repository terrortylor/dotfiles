#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd ${SCRIPT_DIR} > /dev/null || exit


source ../scripts/common.sh

info "Setting up git"

link_file "${SCRIPT_DIR}/gitconfig" ~/.gitconfig
link_file "${SCRIPT_DIR}/gitconfig_work" ~/.gitconfig_work

popd > /dev/null || exit

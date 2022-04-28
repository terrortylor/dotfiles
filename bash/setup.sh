#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd ${SCRIPT_DIR} > /dev/null || exit


source ../scripts/common.sh

info "Setting up bashrc"

link_file "${SCRIPT_DIR}/bashrc.d" ~/.bashrc.d

popd > /dev/null || exit

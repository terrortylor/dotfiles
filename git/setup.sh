#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd "${SCRIPT_DIR}" > /dev/null || exit


# shellcheck source=./scripts/common.sh
source ../scripts/common.sh

info "Setting up git"

link_file "${SCRIPT_DIR}/gitconfig" ~/.gitconfig
link_file "${SCRIPT_DIR}/gitconfig_personal" ~/.gitconfig_personal

if [[ $OSTYPE == 'darwin'* ]]; then
  link_file "${SCRIPT_DIR}/gitconfig_orcid" ~/.gitconfig_work
else
  link_file "${SCRIPT_DIR}/gitconfig_work" ~/.gitconfig_work
  link_file "${SCRIPT_DIR}/gitconfig_orcid" ~/.gitconfig_orcid
  link_file "${SCRIPT_DIR}/gitconfig_testevolve" ~/.gitconfig_testevolve
fi

popd > /dev/null || exit

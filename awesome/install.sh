#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd ${SCRIPT_DIR} > /dev/null || exit

source ../scripts/common.sh

info "Arming SUDO"
sudo su -c ""

info "Install awesome and dependecies"
add_package awesome

popd > /dev/null || exit

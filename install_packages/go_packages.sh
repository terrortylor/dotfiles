#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd ${SCRIPT_DIR} > /dev/null || exit

source ../scripts/common.sh

go_install() {
  run_script "go install ${1}"
}

info "Installing GO packages"
go_install "golang.org/x/tools/gopls@latest"
go_install "github.com/go-delve/delve/cmd/dlv@latest"

popd > /dev/null || exit

#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd "${SCRIPT_DIR}" > /dev/null || exit

# shellcheck source=./scripts/common.sh
source ../scripts/common.sh

npm_install() {
  run_script "npm install --global ${1}"
}

info "Installing NPM packages"
npm_install "cdktf-cli@latest"
npm_install "typescript-language-server"
npm_install "typescript"

popd > /dev/null || exit

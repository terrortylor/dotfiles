#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd "${SCRIPT_DIR}" > /dev/null || exit

# shellcheck source=./scripts/common.sh
source ../scripts/common.sh

pip_install() {
  run_script "pip3 install ${1}"
}

info "Installing PIP packages"
pip_install "cfn-lint"

popd > /dev/null || exit

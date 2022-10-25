#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd "${SCRIPT_DIR}" > /dev/null || exit

# shellcheck source=./scripts/common.sh
source ../scripts/common.sh

info "Installing other packages"
find other/. -name "*.sh" | while read -r installer ; do 
  source "${installer}"
done

popd > /dev/null || exit

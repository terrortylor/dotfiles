#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd "${SCRIPT_DIR}" > /dev/null || exit

# shellcheck source=./scripts/common.sh
source ../scripts/common.sh

info "Installing work packages"
find work/. -name "*.sh" | while read -r installer ; do 
  run_script "${installer}"
done

popd > /dev/null || exit

#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd "${SCRIPT_DIR}" > /dev/null || exit

# shellcheck source=./scripts/common.sh
source ../scripts/common.sh

info "General workflow packages"
brew install lazygit
brew install fd
brew install tree
brew install fzf
brew install bat
brew install jq
brew install tmux
brew install ripgrep
brew install k9s

popd > /dev/null || exit

#! /bin/bash

set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd /tmp > /dev/null || exit

# wget -o vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
# sudo apt install ./vscode.deb

source "${SCRIPT_DIR}/../scripts/common.sh"
link_file "${SCRIPT_DIR}/settings.json" ~/.config/Code/User/settings.json

while read -r p; do
  echo "Installing: $p"
 code --install-extension "$p"
done < "${SCRIPT_DIR}/extension-list.txt"
popd > /dev/null || exit

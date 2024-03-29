#! /bin/bash

set -e

pushd /tmp > /dev/null
VERSION=$(curl -sL https://api.github.com/repos/sumneko/lua-language-server/releases/latest | jq -r ".tag_name")
echo "Downloading version: $VERSION"

wget "https://github.com/sumneko/lua-language-server/releases/download/${VERSION}/lua-language-server-${VERSION}-linux-x64.tar.gz"

mkdir lua-language-server
tar xvf "lua-language-server-${VERSION}-linux-x64.tar.gz" -C lua-language-server

sudo mv lua-language-server /opt/.
popd > /dev/null


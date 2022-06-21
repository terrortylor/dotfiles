#! /bin/bash

set -ev

pushd /tmp > /dev/null
VERSION=$(curl -sL https://api.github.com/repos/mvdan/sh/releases/latest | jq -r ".tag_name")
echo "Downloading version: $VERSION"

wget "https://github.com/mvdan/sh/releases/download/${VERSION}/shfmt_${VERSION}_linux_amd64"

sudo mv "shfmt_${VERSION}_linux_amd64" /usr/local/bin/shfmt
chmod +x /usr/local/bin/shfmt
popd > /dev/null


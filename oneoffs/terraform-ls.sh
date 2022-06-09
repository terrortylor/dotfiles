#! /bin/bash

set -e

pushd /tmp > /dev/null
VERSION=$(curl -sL https://api.github.com/repos/hashicorp/terraform-ls/releases/latest | jq -r ".tag_name")
echo "Downloading version: $VERSION"

TRIMMED_VERSION=$(echo $VERSION | sed -e 's/^v//g')
wget https://github.com/hashicorp/terraform-ls/releases/download/${VERSION}/terraform-ls_${TRIMMED_VERSION}_linux_amd64.zip

unzip terraform-ls_${TRIMMED_VERSION}_linux_amd64.zip

sudo mv terraform-ls /usr/local/bin/.
popd > /dev/null

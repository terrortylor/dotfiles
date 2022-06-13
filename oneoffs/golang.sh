#! /bin/bash

set -e

VERSION=1.18.3

pushd /tmp > /dev/null
wget https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz
tar -C /usr/local -xzf go${VERSION}.linux-amd64.tar.gz
popd > /dev/null

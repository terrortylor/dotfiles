#! /bin/bash

if command -v bats &> /dev/null; then
    echo "bats command found, skipping"
    exit
fi

cd /tmp || exit
git clone https://github.com/bats-core/bats-core.git
cd bats-core || exit
sudo ./install.sh /usr/local

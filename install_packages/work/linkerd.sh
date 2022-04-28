#! /bin/bash
# From: https://linkerd.io/2.10/getting-started/
# and: https://github.com/linkerd/linkerd2/releases/

if command -v linkerd &> /dev/null; then
    echo "linkerd command found, skipping"
    exit
fi

cd /tmp
wget https://github.com/linkerd/linkerd2/releases/download/stable-2.11.2/linkerd2-cli-stable-2.11.2-linux-amd64
sudo install -o root -g root -m 0755 linkerd2-cli-stable-2.11.2-linux-amd64 /usr/local/bin/linkerd

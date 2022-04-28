#! /bin/bash
# From: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux

if command -v k9s &> /dev/null; then
    echo "k9s command found, skipping"
    exit
fi

cd /tmp
wget https://github.com/derailed/k9s/releases/download/v0.25.18/k9s_Linux_x86_64.tar.gz
tar xvf k9s_Linux_x86_64.tar.gz
sudo mv k9s /usr/local/bin

#! /bin/bash
# From: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux

if command -v lazygit &> /dev/null; then
    echo "lazygit command found, skipping"
    exit
fi

cd /tmp
wget https://github.com/jesseduffield/lazygit/releases/download/v0.34/lazygit_0.34_Linux_x86_64.tar.gz
tar xvf lazygit_0.34_Linux_x86_64.tar.gz
sudo install -o root -g root -m 0755 lazygit /usr/local/bin/lazygit



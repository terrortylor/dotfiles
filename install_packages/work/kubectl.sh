#! /bin/bash
# From: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux

if command -v kubectl &> /dev/null; then
    echo "kubectl command found, skipping"
    exit
fi

cd /tmp
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo mkdir -p /usr/local/bin
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


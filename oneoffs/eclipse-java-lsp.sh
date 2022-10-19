#!/usr/bin/env bash
set -e

if [ -d /opt/jdt-language-server ]; then
  echo "remove current dir first: /opt/jdt-language-server"
  exit 1
fi

sudo mkdir -p /opt/jdt-language-server
dir=$(mktemp -d -p /tmp)
echo "Temp dir: ${dir}"
pushd "${dir}" > /dev/null || exit
wget https://download.eclipse.org/jdtls/snapshots/latest.txt
cat latest.txt

wget https://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
tar -xvf jdt-language-server-latest.tar.gz
rm jdt-language-server-latest.tar.gz
sudo cp -r * /opt/jdt-language-server/.

popd > /dev/null || exit

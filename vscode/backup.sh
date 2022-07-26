#! /bin/bash

set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
code --list-extensions > "${SCRIPT_DIR}/extension-list.txt"

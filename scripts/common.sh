#! /bin/bash

info() {
	printf "\r [ \033[00;34mINFO\033[0m ] $1\n"
}

skip() {
	printf "\r [ \033[00;33mSKIP\033[0m ] $1\n"
}

success() {
	printf "\r [ \033[00;32m OK \033[0m ] $1\n"
}

# I'd like this to be "fail" but that breaks bats...?
error() {
	printf "\r [ \033[00;31mFAIL\033[0m ] $1\n"
	echo ''
	#exit
}

# Args:
# 1 - Git Clone URL
# 2 - Destination Path
clone() {
	info "\tCloning $1"
	if [ -d "$2" ]; then
		skip "\tSkipping clone, path found: $2"
		return 0
	fi
	if git clone "$1" "$2"; then
		success
	else
		error
	fi
}

# TODO be nice to have this func print out what it's symlinking
# Args:
# 1 - file	
# 2 - target	
link_file() {
	info "\tCreating symlink: ${2}"
	if [ ! -f "$1" -a ! -d "$1" ]; then
		error "\tTarget does not exist: $1"
		return 1
	fi
	if [ -L "$2" ]; then
    local src="$(readlink -fv $2)"
    if [ "$src" == "$1" ]; then
      skip "\tLink exists"
    else
      error "\tLink exists to wrong target, wanted: $1 - $2"
      return 1
    fi
  elif [ -f "$2" -o -d "$2" ]; then
    error "\tLink already exists as file or directory: $2"
    return 1
  else
    ln -s "$1" "$2"
    success
	fi
}

create_dir() {
  info "\tCreating directory: $1"
  if mkdir -p "$1"; then
    success "\tCreating directory: $1"
  else
    error "\tCreating directory: $1"
    return 1
  fi
}

add_package() {
  OUTPUT="$(mktemp)"
  dpkg -s "${1}" &> $OUTPUT
  if [ $? -ne 0 ]; then
    if  ! grep -q "is not installed and no information is available" $OUTPUT; then
      error "Installing: ${1}"
      cat $OUTPUT
      rm $OUTPUT
      exit 1
    fi
  fi
  if  grep -q "Status: install ok installed" $OUTPUT; then
    rm $OUTPUT
    skip "Installed: ${1}"
    return 0
  fi
  sudo apt-get --assume-yes install "${1}" &> $OUTPUT
  if [ $? -ne 0 ]; then
    error "Installing: ${1}"
    cat $OUTPUT
    rm $OUTPUT
    exit 1
  fi
  success "Installing: ${1}"
  rm $OUTPUT
}

run_script() {
  OUTPUT="$(mktemp)"
  sh -c "${1}" &> $OUTPUT
  if [ $? -ne 0 ]; then
    error "Running: ${1}"
    cat $OUTPUT
    exit 1
  fi
  success "Running: ${1}"
  rm $OUTPUT
}

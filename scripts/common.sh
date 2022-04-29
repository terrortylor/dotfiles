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

fail() {
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
		fail
	fi
}

# TODO be nice to have this func print out what it's symlinking
# Args:
# 1 - source	
# 2 - destination	
link_file() {
	info "\tCreating symlink: ${2}"
	if [ ! -f "$1" -a ! -d "$1" ]; then
		fail "\tSource file does not exist: $1"
		return 1
	fi
	if [ -L "$2" ]; then
		if [ -e ${my_link} ] ; then
			local src="$(readlink -fv $2)"
			if [ "$src" == "$1" ]; then
				skip "\tLink exists"
			else
				fail "\tLink exists to wrong path: $1"
			fi
		else
			fail "\tBroken link: $1"
		fi
	elif [ -e ${2} ] ; then
		if [ -f "$2" -o -d "$2" ]; then
			fail "\tDestination exists as file or directory: $2"
		fi
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
    fail "\tCreating directory: $1"
    return 1
  fi
}

add_package() {
  OUTPUT="$(mktemp)"
  dpkg -s "${1}" &> $OUTPUT
  if [ $? -ne 0 ]; then
    fail "Installing: ${1}"
    cat $OUTPUT
    exit 1
  fi
  if  grep -q "Status: install ok installed" $OUTPUT; then
    rm $OUTPUT
    skip "Installed: ${1}"
    return 0
  fi
  sudo apt-get --assume-yes install "${1}" &> $OUTPUT
  if [ $? -ne 0 ]; then
    fail "Installing: ${1}"
    cat $OUTPUT
    exit 1
  fi
  success "Installing: ${1}"
  rm $OUTPUT
}

run_script() {
  OUTPUT="$(mktemp)"
  sh -c "${1}" &> $OUTPUT
  if [ $? -ne 0 ]; then
    fail "Running: ${1}"
    cat $OUTPUT
    exit 1
  fi
  success "Running: ${1}"
  rm $OUTPUT
}

binary_exists() {
  if command -v "${1}" &> /dev/null; then
      info "${1}: command found, skipping"
      return 1
  fi
}

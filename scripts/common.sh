#! /bin/bash

info() {
	printf "\r [ \033[00;34mINFO\033[0m ] $1\n"
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
		success "\tSkipping clone, path found: $2"
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
	info "\tCreating symlink:"
	if [ ! -f "$1" -a ! -d "$1" ]; then
		fail "\tSource file does not exist: $1"
		return 1
	fi
	if [ -L "$2" ]; then
		if [ -e ${my_link} ] ; then
			local src="$(readlink -fv $2)"
			if [ "$src" == "$1" ]; then
				success "\tLink exists"
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

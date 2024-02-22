autoload -Uz git-prune

generate_random_charecters () {
  if [ $# -lt 2 ]
  then
    echo "Usage: $funcstack[1] <charecters, defaults to a-zA-Z0-9> <length, defaults to 32>"
  fi

  charecters="${1:-a-zA-Z0-9}"
  length="${2:-32}"

  cat /dev/urandom | LC_ALL=C tr -dc ${charecters} | fold -w ${length} | head -n 1
}

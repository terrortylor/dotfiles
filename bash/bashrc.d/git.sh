alias gti="git"
alias gi="git"
alias gt="git"

function git-update-all() {
  for d in *; do
    echo $d
    if [[ -d "${d}/.git" ]]; then
      pushd $d
      git up
      popd
    fi
  done
}

function git-branch() {
    context="$(git branch | fzf)"
    if [[ -n ${context} ]]; then
      context=${context//\*}
      git checkout ${context}
    fi
}

function git-root() {
  root=$(git rev-parse --show-cdup 2>/dev/null)
  if [ -z "${root}" ]; then
    return 1
  fi

  cd ${root}
}

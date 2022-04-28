BLUE="\[\033[01;34m\]"
YELLOW="\[\033[33m\]"
GREEN="\[\033[32m\]"
WHITE="\[\033[00m\]"
RED="\[\033[0;31m\]"
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}
export PS1="${BLUE}\w ${YELLOW}\$(parse_git_branch)${RED}> ${WHITE}"

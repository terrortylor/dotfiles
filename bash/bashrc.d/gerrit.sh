# Use fzf to search for repo on server and then checkout
function gerrit-clone() {
  ssh_grep='grep "^Host\s\w" ~/.ssh/config | cut -d " " -f 2'

  # Get gerrit server
  target="$(grep '^Host\s\w' ~/.ssh/config | cut -d ' ' -f 2 | fzf)"

  project="$(ssh $target gerrit ls-projects | fzf)"

  if [[ ${project} != *"/"* ]]; then
    echo "Parent Project Selected, exiting..."
    exit 1
  fi

  echo "Selected repo: ${project}"
  dir=~/workspace/${project}

  if [[ ! -d ~/workspace/${project} ]]; then
    parent=${project%%/*}
    mkdir -p ~/workspace/${parent}

    cd ~/workspace/${parent}
    git clone ${target}:${project}
    cd ~/workspace/${project}
  else
    cd ~/workspace/${project}
    git up
  fi
}

# helper func for gerrit-acces-check
# so sort of fake run loop
function select_access_show_users() {
  levels=(
    build
    submit
    review
  )
  access_level="$(printf '%s\n' ${levels[@]} | fzf)"

  # get group name
  group_name="${1//\//-}-${access_level}"

  ssh $target gerrit ls-members ${group_name} | fzf
  # TODO how to exit properly?
  select_access_show_users ${1}
}

# FZF wrapper around making calls to gerrit cli over ssh to view users in a group
#
# Requires ssh key to be added!!
#
# List projects, exist if parent selected
# Gives option to select group access level
# Then looks betwen access level and users lst until Ctrl-C
function gerrit-access-check() {
  ssh_grep='grep "^Host\s\w" ~/.ssh/config | cut -d " " -f 2'
  #$ssh_grep

  ## Get gerrit server
  target="$(grep '^Host\s\w' ~/.ssh/config | cut -d ' ' -f 2 | fzf)"

  project="$(ssh $target gerrit ls-projects | fzf)"

  if [[ ${project} != *"/"* ]]; then
    echo "Parent Project Selected, exiting..."
    exit 1
  fi

  select_access_show_users ${project}
}

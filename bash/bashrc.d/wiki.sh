_NOTES_DIR=~/personal-workspace/notes

gonotes() {
  cd ${_NOTES_DIR}
  if [ ! -z $TMUX ]; then
    tmux rename-window notes
  fi
}

notes() {
  gonotes
  vim -c "Telescope find_files"
}

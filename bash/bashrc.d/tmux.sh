alias tmuxwork="tmux at -t work"

tmux_open_session() {
  if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters, expected 1 got $#"
    echo -e "Usage:\n${FUNCNAME[0]} <SESSION>"
    return 1
  fi

  if [[ $(tmux ls) == *"${1}:"* ]]; then
    tmux attach -t ${1}
  else
    tmux new-session -s ${1}
  fi
}

# Sets the TMUX window name, does nothing if not in TMUX
# Args:
# 1 - int, if greater than 0 then prompt user if can't work it out
tmux_set_window_name() {
  if [ ! -z $TMUX ]; then
    git_root=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ $? -eq 0 ]; then
      # Check in in work related workspace
      if [[ $git_root == *"${HOME}/workspace/"* ]]; then
        # If work related then grab last to directories
        name=$(echo "${git_root}" | rev | cut -d/ -f 1,2 | rev)
      else
        # just get current directory name
        name=${git_root##*/}
      fi
      tmux rename-window ${name}
    else
      if [ ${1} -gt 0 ]; then
        read -p "Can't work out name, please enter: " name
        tmux rename-window ${name}
      fi
    fi
  fi
}

alias tsn="tmux_set_window_name 1"

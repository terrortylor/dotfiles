git_up_all_directories() {
  for i in $(ls -d */); do
    pushd $i
    # Only update if valid repository
    if git rev-parse --git-dir > /dev/null 2>&1; then
      git up
    else
      echo "Not a git repo... skipping"
    fi
    popd
  done
}

# start NVM as required

function node() {
  echo "nvm not loaded, loading..."
  unset -f node
  source startNVM
  node $@
}

function npm() {
  echo "nvm not loaded, loading..."
  unset -f npm
  source startNVM
  npm $@
}

function yarn() {
  echo "nvm not loaded, loading..."
  unset -f yarn
  source startNVM
  yarn $@
}

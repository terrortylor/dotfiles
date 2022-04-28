function kubectl() {
  echo "kubectl completion not loaded, loading..."
  unset -f kubectl
  # this is to fix a bug...?
  source /etc/bash_completion
  source <(kubectl completion bash)
  kubectl $@
}

# Use fzf to change kubectl context
function kc-set-context() {
  context="$(kubectl config get-contexts | awk 'NR>1 {if ($1 ~ /\*/) {print $1 " " $2} else {print "  "$2} }' | fzf)"
  if [[ -n ${context} ]]; then
    context=${context//\*}
    kubectl config use-context ${context}
  fi
}


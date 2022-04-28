if hash gcloud 2>/dev/null; then
  # Use fzf to set gcloud config
  function az-set-subscription(){
    context="$(az account list --output table | awk 'NR>2 {if ($5 == "True") {print "* " $1} else {print "  " $1} }' | fzf)"
    if [[ -n ${context} ]]; then
      context=${context//\*}
      az account set --subscription ${context}
    fi
  }
fi

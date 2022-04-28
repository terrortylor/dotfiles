if hash gcloud 2>/dev/null; then
  # Use fzf to set gcloud config
  function gc-set-config(){
    context="$(gcloud config configurations list | awk 'NR>1 {if ($2 == "True") {print "* " $1} else {print "  " $1} }' | fzf)"
    if [[ -n ${context} ]]; then
      context=${context//\*}
      gcloud config configurations activate ${context}
    fi
  }

  function gc-ssh(){
    instance="$(gcloud compute instances list | awk 'NR>1 {print $1}' | fzf)"
    if [[ -n ${instance} ]]; then
      gcloud compute ssh ${instance}
    fi
  }
fi

if hash docker 2>/dev/null; then
  # Use fzf to set gcloud config
  function docker-stop(){
    containerid="$((docker ps | awk 'NR>1 {print $1 " " $2}' | fzf) | awk '{print $1}')"
    if [[ -n ${containerid} ]]; then
      echo "Stopping: ${containerid}"
      docker stop ${containerid}
    fi
  }

  # docker-compose aliases
  alias dcu="docker-compose up -d"
  alias dcul="docker-compose up && docker-compose logs -f"
  alias dcd="docker-compose down"

  # docker aliases/functions
  dsa() {
    echo 'Stopping all containers'
    docker stop $(docker ps -a -q)
  }

  dra() {
    echo 'Removing all containers'
    docker rm $(docker ps -a -q)
  }

  dri() {
    echo 'Removing all images'
    docker rmi -f $(docker images -q)
  }
  alias dsp="echo 'Docker system prune'; yes | docker system prune"
  alias dpsa="docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}'"
  alias dia="echo 'List all images'; docker images -a"
fi

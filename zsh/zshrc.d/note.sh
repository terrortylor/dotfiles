todaynote () {
  notePath="journal/$(date '+%Y')/$(date '+%U-%Y-%B').md"
  echo "${notePath}"
  cd ~/personal-workspace/notes
  nvim ${notePath}
}

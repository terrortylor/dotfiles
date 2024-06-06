export SDKMAN_DIR="${HOME}/.sdkman"

 lazy_load 'sdk' 'kotlin' 'gradle' 'mvn' <<- 'EOF'
 [[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"
EOF

# append to history, not overwrite
shopt -s histappend
# Attempt to save all lines of a multiple-line command in the same entry
shopt -s cmdhist
# Print the timestamp of each command
HISTTIMEFORMAT='%F %T '
# After each command, append to the history file and reread it
# export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$"\n"}history -a; history -c; history -r"
# Do not store a duplicate of the last entered command
HISTCONTROL=ignoredups
HISTIGNORE="ls:ll:ls -al:pwd: git status;git s;git st"

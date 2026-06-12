alias tasksyesterday="task end.after:yesterday completed"
alias taskstoday="task end.after:yesterday completed"
alias tan='task annotate'
alias tam='task modify'
alias tnn='task modify +next'
alias tout='task modify -in'
alias tdone='task done'
alias toutdone='task done -in'
# _task_register_helper tdone done
# _task_register_helper toutdone done -id
alias tlan='task annotate "$(task +LATEST uuids)"'
alias tlam='task "$(task +LATEST uuids)" modify'
alias tlin='task "$(task +LATEST uuids)" info'
# alias tawc='task add +computer +work '

alias in='task add +in'

_task_id_or_last() {
taskid=$@
if [ -z $taskid ]; then
  taskid=$(task +LATEST uuids)
fi
echo $taskid
}

# Registers a local command, that will run a set of
# task subcommands with either the given id or
# the last created task UUID
# i.e. _task_register_helper goat info
# can then be called with:
# goat
# goat 4
_task_register_helper() {
  aliasName=$1
    shift
    taskCommands=$@
    $aliasName () {
    taskid=$(_task_id_or_last $@)
    echo $taskid
    /opt/homebrew/bin/task $taskCommands ${taskid}
  }
}

tickle () {
    deadline=$1
    shift
    in +tickle wait:$deadline $@
}
alias tick=tickle

taskNote () {
  task=$1
  if [ -z $task ]; then
    echo "Please provide a task ID"
    exit
  fi
  uuid=$(task _get ${task}.uuid)
  if [ -z $uuid ]; then
    echo "UUID not found for task, check task exists"
    exit
  fi
  echo "Task found: ${task}, uuid: ${uuid}"
  $EDITOR ~/personal-workspace/notes/taskwarrior/${uuid}.md
}

alias tasknote=taskNote

alias tin='task in'
alias tn='task next'

_taskFilter () {
    context=$1
    shift
    task +$context $@
    echo "task +$context $@"
    echo $context
    echo $@
}
alias tc='_taskFilter'

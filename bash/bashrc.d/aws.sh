function aws() {
	echo "aws not loaded, loading..."
	unset -f aws
  complete -C '/usr/local/bin/aws_completer' aws
	aws $@
}

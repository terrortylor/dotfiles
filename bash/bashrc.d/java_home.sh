case `uname` in
  Darwin)
    # commands for OS X go here
    export JAVA_HOME=$(/usr/libexec/java_home)
  ;;
  Linux)
    # commands for Linux go here
  ;;
esac

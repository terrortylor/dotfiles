case $(uname) in
  Darwin)
    # commands for OS X go here
  ;;
  Linux)
    # commands for Linux go here
    export PATH=/opt/packer:$PATH
  ;;
esac

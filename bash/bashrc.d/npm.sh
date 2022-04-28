# if command -v npm &> /dev/null; then
#   case `uname` in
#     Darwin)
#       # commands for OS X go here
#       ;;
#     Linux)
#       export NPM_CONFIG_PREFIX="${HOME}/.npm-global"
#       if [ ! -d $NPM_CONFIG_PREFIX ]; then
#         mkdir $NPM_CONFIG_PREFIX
#       fi
# 
#       # commands for Linux go here
#       export PATH=$NPM_CONFIG_PREFIX/bin:$PATH
#     ;;
#   esac
# fi

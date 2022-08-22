alias lg=lazygit

alias EditBashrcdFiles="vim -c 'EditBashrcdFiles'"

# Create directory and move into it
mkcd() {
  if [ -d "${1}" ]; then
    echo "Directory already exists"
  else
    mkdir -p ${1}
  fi
  cd ${1}
}

# Function to search ~/.bashrc.d for any aliases based on a key
# word; it then prints out the alias name and value on seperate
# lines to aid in readability.
# FIXME Not sure this works for functions any more
# TODO add alias or function wrapper so can call 'member'
find_alias_function() {
  if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters, expected 1 got $#"
    return 0
  fi
  echo "Searching for term: $1 in .bashrc.d"
  # Search aliases
  while read -r line; do
    if [[ ${line} == *"alias"* ]]; then
      found_entry=$(echo $line | cut -d ' ' -f2-)
      alias_name=$(echo $found_entry | cut -d '=' -f1)
      alias_value=$(echo $found_entry | cut -d '=' -f2-)
      RED='\033[0;36m'
      NC='\033[0m' # No Color
      printf "alias ${RED}${alias_name}${NC}\n\t${alias_value}\n"
    fi
  done < <( grep -ih "^alias.*${1}.*" ~/.bashrc.d/* )

  # Search functions
  while read -r line; do
    if [[ ${line} == *"alias"* ]]; then
      file_name=$(echo $line | cut -d ':' -f1,2)
      function_name=$(echo $line | cut -d ' ' -f2)
      RED='\033[0;36m'
      NC='\033[0m' # No Color
      printf "function ${RED}${function_name}${NC}\n\tFile: ${file_name}\n"
    fi
  done < <( grep -in "^.*${1}.*()\s{" ~/.bashrc.d/* )
}

# Open file(s) with fzf in vim
fvim() {
	local files

	# TODO this is repeated, tidy up
	if type bat >/dev/null; then
		files="$(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')"
	else
		files="$(fzf --preview 'cat {}')"
	fi

	if [[ -n $files ]]; then
		nvim -- "${files}"
	fi
}

# fzf find a file and print name, called from bash keybinding
f_insert_file_name() {
	local file

	if type bat >/dev/null; then
		file="$(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')"
	else
		file="$(fzf --preview 'cat {}')"
	fi

	if [[ -n $file ]]; then
		printf '..%s..' "$file"
	fi
}

# fzf into directory under current
# Taken from: https://github.com/junegunn/fzf/wiki/examples#changing-directory
# I am too lazy to cd **<TAB>
fcd() {
	local dir
	dir=$(find "${1:-.}" -path '*/\.*' -prune \
		-o -type d -print 2>/dev/null | fzf +m) &&
		cd "$dir" || exit

	tmux_set_window_name
}

# more focused
ffcd() {
	items=$(find ~/workspace -type d -path '*/node_modules' -prune -o -type d -print)
	items+=$(find ~/personal-workspace -maxdepth 5 -type d -path '*/node_modules' -prune -o -type d -print)
	cd=$(echo "$items" | fzf)
	if [[ -n ${cd} ]]; then
		cd "${cd}" || exit

		tmux_set_window_name
	fi
}

# fzf find a directry and print, called from bash keybinding
f_insert_directory_name() {
	local dir
	dir=$(find "${1:-.}" -path '*/\.*' -prune \
		-o -type d -print 2>/dev/null | fzf +m) &&
		if [[ -n $dir ]]; then
			printf '..%s..' "${dir}"
		fi
}

fcat() {
	local file

	if type bat >/dev/null; then
		file="$(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')"
	else
		file="$(fzf --preview 'cat {}')"
	fi

	if [[ -n $file ]]; then
		if type bat >/dev/null; then
			bat $file
		else
			cat $file
		fi
	fi
}

rgfzfpreview() {
	$1 >>/tmp/preview
	bat --style=numbers --color=always --line-range :500 $1
}

# Wrapper for ripgrep and fzf, using bat as preview
# To handle the ripgrep line, an external script RgFzfPreview is called, this
# must be on the path
# This is adapted from the fzf man docs
rgfzf() {
	path=${1}
	query=${2}
	RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
	FZF_DEFAULT_COMMAND="$RG_PREFIX '$query' ${path}" \
		fzf --bind "change:reload:$RG_PREFIX {q} ${path} || true" \
		--ansi --phony --query "$query" \
		--layout=reverse \
		--preview-window=bottom \
		--preview 'RgFzfPreview {}'
}

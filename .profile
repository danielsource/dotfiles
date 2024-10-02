export PATH="$HOME/.local/bin:$HOME/bin:$PATH"\
	EDITOR=/usr/bin/vi\
	FZF_DEFAULT_OPTS='--no-color'

if [ -d ~/.profile.d ]; then
	for file in ~/.profile.d/*.sh ; do
		. "$file"
	done
	unset file
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

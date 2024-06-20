export PATH="$PATH:$HOME/.local/bin:$HOME/bin" FZF_DEFAULT_OPTS='--no-color'

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

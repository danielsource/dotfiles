# fzf customization
unset fzf_find_args
if [ -L "$HOME/Documents" ]; then
	fzf_find_args=./Documents/
fi
if [ -L "$HOME/Downloads" ]; then
	fzf_find_args="$fzf_find_args ./Downloads/"
fi
fzf_find_args="$fzf_find_args -not \( -path '*/.stversions/*' -or -path '*/.git/*' -or -path '*/.metadata/*' -or -path '*/resources/app/*' -or -path '*/mesa_shader_cache/*' -or -path './Pictures/Camera/*' -or -path './.mozilla/*' -or -path './.arduino*/*' -or -path './.cache/*' -or -path '*/libreoffice/*' -or -path '*/nvim/undo/*' -or -path '*/BraveSoftware/*' \)"
export FZF_DEFAULT_COMMAND="find . $fzf_find_args 2>/dev/null" \
	FZF_CTRL_T_COMMAND="find . $fzf_find_args 2>/dev/null" \
	FZF_ALT_C_COMMAND="find . $fzf_find_args -type d 2>/dev/null" \
	FZF_DEFAULT_OPTS='--no-color'
unset fzf_find_args
# end of fzf customization

export PATH="$PATH:$HOME/.local/bin:$HOME/bin"

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

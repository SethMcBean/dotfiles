# just source my bashrc when Im too lazy to set my term emulator to /bin/bash instead of /bin/login
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"


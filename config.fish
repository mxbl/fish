if not status is-interactive
	exit
end

set EDITOR nvim
set fish_greeting
set -x SSH_AUTH_SOCK /run/user/(id -u)/openssh_agent

fish_add_path $HOME/.local/bin
fish_add_path /usr/local/go/bin

if set -q XDG_SESSION_TYPE; and test $XDG_SESSION_TYPE = x11
	setxkbmap -option 'shift:both_capslock'
	xset r rate 200
	xset b off
end

# set -g direnv_fish_mode eval_on_arrow

if command -sq direnv
	direnv hook fish |.
	direnv export fish |.
end
command -sq zoxide; and zoxide init fish |.
command -sq atuin; and atuin init fish |.

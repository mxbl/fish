if not status is-interactive
	exit
end

set EDITOR nvim
set fish_greeting

if set -q XDG_SESSION_TYPE; and test $XDG_SESSION_TYPE = x11
	setxkbmap -option 'shift:both_capslock'
	xset r rate 200
	xset b off
end

command -sq zoxide; and zoxide init fish |.
command -sq atuin; and atuin init fish |.

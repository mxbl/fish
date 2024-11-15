if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
set -x PATH \
	$HOME/bin \
	$HOME/.cargo/bin \
	/nix/var/nix/profiles/default/bin \
	/usr/local/go/bin \
	/usr/local/bin \
	/usr/bin \
	/usr/sbin

if not set -q SSH_CLIENT; and not set -q SSH_CONNECTION
	setxkbmap -option 'shift:both_capslock'
	xset r rate 200
	xset b off
end

which zoxide > /dev/null; and zoxide init fish |.
which atuin > /dev/null; and atuin init fish |.

bind \cy accept-autosuggestion

if not status is-interactive
	exit
end

set fish_greeting
set -x PATH \
	$HOME/bin \
	$HOME/.cargo/bin \
	$HOME/.nix-profile/bin \
	/nix/var/nix/profiles/default/bin \
	/usr/local/go/bin \
	/usr/local/bin \
	/usr/bin \
	/usr/sbin

if not test $XDG_SESSION_TYPE = tty
	setxkbmap -option 'shift:both_capslock'
	xset r rate 200
	xset b off
end

which zoxide > /dev/null; and zoxide init fish |.
which atuin > /dev/null; and atuin init fish |.

bind \cy accept-autosuggestion

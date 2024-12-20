if not status is-interactive
	exit
end

set fish_greeting
set -x PATH \
	$HOME/bin \
	$HOME/go/bin \
	$HOME/.cargo/bin \
	$HOME/.nix-profile/bin \
	/run/wrappers/bin \
	/run/current-system/sw/bin \
	/etc/profiles/per-user/mx/bin \
	/usr/local/go/bin \
	/usr/local/bin \
	/usr/bin \
	/usr/sbin

if set -q XDG_SESSION_TYPE; and not test $XDG_SESSION_TYPE = tty
	setxkbmap -option 'shift:both_capslock'
	xset r rate 200
	xset b off
end

which zoxide &> /dev/null; and zoxide init fish |.
which atuin &> /dev/null; and atuin init fish |.

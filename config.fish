if not status is-interactive
	exit
end

set fish_greeting
set -x EDITOR nvim

# SSH agent socket discovery
begin
	set -l base /run/user/(id -u)
	set -l sockets \
		$base/keyring/ssh \
		$base/ssh-agent \
		$base/openssh_agent

	for sock in $sockets
		if test -S $sock
			set -x SSH_AUTH_SOCK $sock
			break
		end
	end
	set -q SSH_AUTH_SOCK; or echo "[ERR] Could not find a valid SSH_AUTH_SOCK"
end

fish_add_path $HOME/.local/bin

if set -q XDG_SESSION_TYPE; and test $XDG_SESSION_TYPE = x11
	setxkbmap -option 'shift:both_capslock'
	xset r rate 400
	xset b off
end

# set -g direnv_fish_mode eval_on_arrow

if command -sq direnv
	direnv hook fish |.
	direnv export fish |.
end
command -sq zoxide; and zoxide init fish |.
command -sq atuin; and atuin init fish |.
command -sq mise; and mise activate fish |.

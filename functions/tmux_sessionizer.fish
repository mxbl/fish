set -x dirs \
	~/ \
	~/.config \
	~/git \
	~/dev

function tmux_sessionizer
	#function dot_tmux -d "Source this projects or a global tmux session config"
	#	if test -f ./.tm
	#		. ./.tm
	#	else
	#		. ~/.tm
	#	end
	#	functions -e dot_tmux
	#end
	#
	#if test (count $argv) -gt 0
	#	dot_tmux
	#	clear
	#	return
	#end

	set -l selected (find $dirs -mindepth 1 -maxdepth 1 -type d | fzf)
	if test -z $selected; return; end
	set -l selected_name (basename $selected)

	if not tmux has-session -t=$selected_name 2>/dev/zero
		tmux new-session -ds $selected_name -c $selected
	end

	function switch_to -d "Switch or attach to tmux session"
		if not set -q TMUX
			tmux attach-session -t $argv[1]
		else
			tmux switch-client -t $argv[1]
		end
		functions -e switch_to
	end

	switch_to $selected_name
	#tmux send-keys -t $selected_name "tmux_sessionizer source_dot_tm" Enter
end

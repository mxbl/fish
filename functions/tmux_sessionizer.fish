set -x dirs \
	~ \
	~/dev \
	~/git \
	~/.config \
	~/notes

function tmux_sessionizer
	set -l selected (find $dirs -mindepth 1 -maxdepth 1 -type d \
		! -path "*/.ansible" ! -path "*.OLD" | fzf)

	if test -z $selected; return; end

	# Replace . for hidden directories with _
	set -l selected_name (basename $selected)
	if string match -rq "\." $selected_name
		set selected_name (string replace -ra "\." "_" $selected_name)
	end

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

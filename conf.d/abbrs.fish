abbr -a sc source ~/.config/fish/config.fish
abbr -a mv mv -iv
abbr -a cp cp -riv
abbr -a rm rm -Iv
abbr -a du du -csh
abbr -a dm --set-cursor du -h --max-depth=%
abbr -a df df -h
abbr -a gp   --set-cursor "git push % (git_branch_name)"
abbr -a update --set-cursor "git add . && git commit -m '%' && git push origin (git_branch_name)"

abbr -a tm tmux
abbr -a ta tmux attach -t
abbr -a tad tmux attach -d -t
abbr -a tn tmux new-session -s
abbr -a tl tmux list-sessions

abbr -a sy systemctl

function histreplace
	switch "$argv[1]"
	case !!
		echo -- $history[1]
		return 0
	case '!$'
		echo -- $history[1] | read -lat tokens
		echo -- $tokens[-1]
		return 0
	end
	return 1
end

abbr -a !! --function histreplace --position anywhere
abbr -a '!$' --function histreplace --position anywhere

# ansible-vault
abbr -a enc ansible-vault encrypt
abbr -a dec ansible-vault decrypt

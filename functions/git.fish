function git_branch_name --description "The currents branch name"
	printf '%s' (git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function git_is_dirty
	printf '%s' (git status -s --ignore-submodules=dirty 2>/dev/null)
end

function git_commit_hash
	printf '%s' (git log --pretty=format:'%h' -n 1 2>/dev/null)
end

function git_commit_message
	set msg (git log -1 --pretty=%B 2>/dev/null | head -n1)
	string sub -l $argv[1] $msg
end

function git_status
	set -l git_branch (git_branch_name)
	if test -z "$git_branch"
		return
	end

	set -l git_status ""
	if [ (git_is_dirty) ]
		switch (git branch -qv --no-color)
			case "*[ahead *"
				set git_status $git_status⬆
			case "*behind *"
				set git_status $git_status⬇
		end

		for i in (git status --porcelain | cut -c 1-2 | sort | uniq)
			switch $i
				case "."
					set git_status $git_status✚
				case " D"
					set git_status $git_status✖
				case "*M*"
					set git_status $git_status▲
				case "*R*"
					set git_status $git_status➜
				case "*U*"
					set git_status $git_status═
				case "??"
					set git_status $git_status≠
			end
		end
	end

	echo -n -s $git_status:(set_color -o purple)$git_branch(set_color normal):

	# commit hash
	printf '%s%s' (set_color ff8800)(git_commit_hash)

	# commit message
	if test (tput cols) -ge 50
		set msg_len \
			(math (tput cols) - (string length (current_working_directory)) - 25)
		echo -n -s (set_color 444444)/(git_commit_message $msg_len).../
	end

	echo -n -s (set_color normal)\n
end

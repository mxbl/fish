. (dirname (status --current-filename))/git.fish

set -l turquoise (set_color 5fdfff)
set -l purple (set_color af5fff)
set -l green (set_color 87ff00)

set -g fish_color_cwd white
set -g fish_color_user white
set -g fish_color_user_root red

function current_working_directory --description "cwd dependent on the git root"
	if [ (git_branch_name) ]
		set -l this_dir (pwd)

		# equals "" in case of a bare repo
		set -l git_dir (git rev-parse --show-toplevel)
		if not test -n "$git_dir"
			set git_dir (git rev-parse --git-dir)
		end

		if begin ; test $git_dir = $this_dir ; or test $git_dir = "." ; end
			echo (string split -r -m1 / $this_dir)[2]
		else
			set git_dir (string split -r -m1 / $git_dir)[1]
			string sub -s2 (string replace $git_dir "" $this_dir)
		end
	else
		prompt_pwd
	end
end

function fish_prompt --description 'Write out the prompt'
	set last_status $status
	set -l normal (set_color normal)
	set -l usercolor (set_color -o $fish_color_user)
	set -l delim '❯ '

	fish_is_root_user; and set delim '# '
	fish_is_root_user; and set usercolor (set_color -o $fish_color_user_root)

	# Show username and hostname prompt only when coming through SSH
	# or as root user
	if not set -q prompt_host
		set -g prompt_host ""
		if set -q SSH_TTY; or fish_is_root_user
			set prompt_host \
				$usercolor$USER$normal@ \
				(set_color $fish_color_host)(hostname)"."(string split -f1 . (dnsdomainname))" "
		end
	end

	set -l branch_name (git_branch_name)
	if test -n "$branch_name"
		echo
	else
		echo -n -s $prompt_host
	end

	echo -n -s (set_color -o $fish_color_cwd)(current_working_directory)$normal" "
	git_status

	test $last_status -ne 0; and \
		set prompt_status (set_color -o $fish_color_status)"✘-$last_status$normal "

	echo -n -s $prompt_status $delim
end


### / Right prompt /

function fish_right_prompt
end

### / Vi mode prompt /

# remove the vi mode prompt on the left side
function fish_mode_prompt
end

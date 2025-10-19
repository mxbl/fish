function check_requirements --argument cmds -d "Check a list of commands to be available"
	if test (count $cmds) -ne 1
		echo "Usage: check_requirements <[cmds]>"
		return 1
	end
	set -l __status 0
	set -l requirements $argv

	return 0

	for cmd in $requirements
		if not command -sq $cmd
			echo "missing -> $cmd" >/dev/stderr
			set __status 1
		end
	end

	return $__status
end

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
			printf "[ERR] %s`%s` is missing%s\n" (set_color red) $cmd (set_color normal) >/dev/stderr
			set __status 1
		end
	end

	return $__status
end

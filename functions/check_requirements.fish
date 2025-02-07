function check_requirements -d "check_requirements <[cmd]>"
	set -l __status 0
	set -l requirements $argv

	for cmd in $requirements
		if not command -sq $cmd
			echo "missing -> $cmd" >/dev/stderr
			set __status 1
		end
	end

	return $__status
end

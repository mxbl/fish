function or_default --argument var default --description "Return var if set and not empty, otherwise return default"
	set -q var && test -n $var && echo $var || echo $default
end

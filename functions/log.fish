function log
	# -b, only from this boot
	# priority 0 (emerg) to 6 (info), exclude 7 (debug)
	# follow after showing the last 1000 lines
	journalctl -b -f -n 1000 --priority 0..6
end

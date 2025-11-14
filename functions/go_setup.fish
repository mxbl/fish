function go_setup --description 'Setup Go environment and install specified Go packages'
	check_requirements go mise; or return 1

	function info --description 'Print info message to stderr'
		printf "[INFO] %s%s%s\n" (set_color 5fdfff) $argv (set_color normal) >/dev/stderr
	end

	set -l go_packages                          \
		golang.org/x/tools/cmd/goimports@latest \
		mvdan.cc/gofumpt@latest                 \
		github.com/segmentio/golines@latest     \

	for pkg in $go_packages
		info "Installing $pkg..."
		go install $pkg
	end

	info "Go environment setup complete."
end

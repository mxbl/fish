function go_setup --description 'Setup Go environment and install specified Go packages'
	check_requirements go mise; or return 1

	function pp --argument type rest --description 'Pretty Print message to stderr'
		switch $type
			case info
				set -f color 5fdfff
			case ok
				set -f color green
			case err
				set -f color red
			case '*'
				set -f color normal
		end
		printf "[%s] %s%s%s\n" (string upper $type) (set_color $color) $rest (set_color normal) >/dev/stderr
	end

	set -l go_packages                          \
		golang.org/x/tools/cmd/goimports@latest \
		mvdan.cc/gofumpt@latest                 \
		github.com/segmentio/golines@latest     \
		github.com/air-verse/air@latest

	for pkg in $go_packages
		pp info "Installing $pkg..."
		go install $pkg
	end

	pp ok "Go environment setup complete."
end

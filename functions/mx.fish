
# NOTE: Tools i usally use that could be added here:
#   (mise) ripgrep, atuin, direnv, fzf, btop

function mx --description 'Install/configure DEV environment tools'
	check_requirements curl git cmake tar unzip; or return 1

	# Install and activate mise
	set -l MISE_INSTALL_PATH $HOME/.local/bin/mise
	command -sq mise; \
		or curl https://mise.run | sh
	$MISE_INSTALL_PATH activate fish |.

	mise use -g eza
	mise use -g zoxide
	mise use -g neovim
	mise use -g node
	mise use -g go

	fish_add_path $HOME/.local/share/mise/installs/go/latest/bin/
	go install golang.org/x/tools/cmd/goimports@latest
	go install mvdan.cc/gofumpt@latest
	go install github.com/segmentio/golines@latest

	git config --global status.short true
	git config --global alias.st status
	git config --global alias.wt worktree
	git config --global alias.ls "log --pretty=format:\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate"
	git config --global alias.yolo "!git commit -m \"$(curl -s https://whatthecommit.com/index.txt)\""

	git clone git@github.com:mxbl/nvim.git ~/.config/nvim 2>/dev/null
end


# NOTE: Tools i usally use that could be added here:
#   (mise) ripgrep, atuin, direnv, fzf, btop

function mx --description 'Install/configure DEV environment tools'
	check_requirements curl git; or return 1
	command -sq mise; \
		or curl https://mise.run | sh

	mise activate fish |.
	mise use -g eza
	mise use -g zoxide
	mise use -g neovim
	mise use -g node
	mise use -g go

	go install golang.org/x/tools/cmd/goimports@latest
	go install mvdan.cc/gofumpt@latest
	go install github.com/segmentio/golines@latest

	git config --global status.short true
	git config --global alias.st status
	git config --global alias.ls "log --pretty=format:\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate"
end

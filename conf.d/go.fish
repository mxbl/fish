set -x GOPATH $HOME/go
set -x GOBIN  $GOPATH/bin

fish_add_path /usr/local/go/bin
fish_add_path $GOBIN

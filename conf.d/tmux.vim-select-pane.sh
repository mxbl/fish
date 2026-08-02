#!/usr/bin/env bash
# Like `tmux select-pane`, but if Vim is running in the current pane it sends
# a `<C-h/j/k/l>` keystroke to Vim instead.
set -e

cmd="$(tmux display -p '#{pane_current_command}')"
cmd="$(basename "$cmd" | tr '[:upper:]' '[:lower:]')"

# echo -n ".tmux-vim-select-pane cmd=$cmd" >> /tmp/test.log

# new-window -n sessionizer tmux_sessionizer

#if [ "${cmd%m}" = "vi" ]; then
if [[ "$cmd" == *"vi"* ]]; then
  direction="$(echo "${1#-}" | tr 'lLDUR' '\\hjkl')"
  # echo -n ",direction=$direction" >> /tmp/test.log
  tmux send-keys "C-$direction" # forward keystroke to vim
else
  tmux select-pane "$@"
fi

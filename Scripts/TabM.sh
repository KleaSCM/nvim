#!/bin/bash
# Manage terminal tabs (tmux example)

echo "=== Tab Manager ==="
tmux new-session -d -s my_session

tmux rename-window -t my_session:0 'Main'
tmux split-window -h -t my_session:0
tmux split-window -v -t my_session:0
tmux new-window -t my_session -n 'Editor'
tmux send-keys -t my_session:1 'vim' C-m
tmux attach -t my_session

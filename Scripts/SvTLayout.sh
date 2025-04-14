#!/bin/bash
# Save and restore terminal layout (tmux example)

echo "=== Layout Saver ==="
tmux save-session -t my_session ~/.tmux_layout
echo "Layout saved!"

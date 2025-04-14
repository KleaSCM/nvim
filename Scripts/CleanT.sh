#!/bin/bash
# Cleans up terminal clutter

echo "=== Terminal Cleanup ==="
echo "Killing abandoned terminals..."
killall -9 bash zsh 2>/dev/null

echo "Clearing command history..."
history -c
echo > ~/.bash_history
echo > ~/.zsh_history

echo "Resetting terminal..."
reset

echo "Cleanup complete!"

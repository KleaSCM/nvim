#!/bin/bash
# Manage tmux sessions

echo "=== Terminal Session Manager ==="
echo "1. List tmux sessions"
echo "2. Create a new tmux session"
echo "3. Attach to an existing session"
echo "4. Kill a tmux session"
echo "5. Exit"
echo

read -p "Choose an option: " CHOICE

case $CHOICE in
    1)
        tmux list-sessions
        ;;
    2)
        read -p "Enter session name: " SESSION_NAME
        tmux new -s "$SESSION_NAME"
        ;;
    3)
        tmux list-sessions
        read -p "Enter session name to attach: " SESSION_NAME
        tmux attach-session -t "$SESSION_NAME"
        ;;
    4)
        tmux list-sessions
        read -p "Enter session name to kill: " SESSION_NAME
        tmux kill-session -t "$SESSION_NAME"
        ;;
    5)
        echo "Goodbye!"
        exit 0
        ;;
    *)
        echo "Invalid option. Try again."
        ;;
esac

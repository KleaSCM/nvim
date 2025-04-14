#!/bin/bash
# Clipboard integration for terminal

echo "=== Clipboard Helper ==="
echo "1. Copy to clipboard"
echo "2. Paste from clipboard"
echo

read -p "Choose an option: " CHOICE

case $CHOICE in
    1)
        echo "Enter text to copy:"
        read TEXT
        echo "$TEXT" | xclip -selection clipboard
        echo "Copied to clipboard!"
        ;;
    2)
        echo "Pasting from clipboard:"
        xclip -selection clipboard -o
        ;;
    *)
        echo "Invalid option. Try again."
        ;;
esac

#!/bin/bash
# Launch multiple terminal windows

echo "=== Multi-Terminal Launcher ==="
gnome-terminal -- bash -c "cd ~/Documents; bash"
gnome-terminal -- bash -c "top; bash"
gnome-terminal -- bash -c "htop; bash"
gnome-terminal -- bash -c "cd ~/Projects; bash"
echo "Terminals launched!"

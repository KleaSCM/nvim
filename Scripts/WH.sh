#!/bin/bash
# Setup a development workspace

echo "=== Workspace Setup ==="
gnome-terminal -- bash -c "cd ~/Projects/my_project; vim; bash"
gnome-terminal -- bash -c "cd ~/Projects/my_project; git status; bash"
gnome-terminal -- bash -c "cd ~/Projects/my_project; ./run_server.sh; bash"
echo "Workspace ready!"

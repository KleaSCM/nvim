#!/bin/bash
# take_control.sh
# Grants full ownership and permissions over a specified folder or file.

echo "=== Goddess Script: Take Control ==="

# Prompt for the target path
read -p "Enter the full path of the file or folder to take control of: " TARGET

# Check if the target exists
if [ ! -e "$TARGET" ]; then
    echo "Error: Target does not exist."
    exit 1
fi

# Confirm action
echo "This will grant FULL permissions and OWNERSHIP of:"
echo "$TARGET"
read -p "Are you sure you want to proceed? (yes/no): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "Operation canceled."
    exit 0
fi

# Grant ownership to the current user
echo "Granting ownership to $(whoami)..."
sudo chown -R "$(whoami):$(whoami)" "$TARGET"

# Grant full permissions
echo "Setting full permissions (read, write, execute)..."
sudo chmod -R 777 "$TARGET"

# Verify success
echo "Verifying permissions..."
ls -ld "$TARGET"

echo "=== Take Control Completed ==="
echo "You now have full ownership and permissions for: $TARGET"

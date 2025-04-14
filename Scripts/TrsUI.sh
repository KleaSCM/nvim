#!/bin/bash
# troubleshooter_ui.sh
# A Bash UI for managing and navigating troubleshooting scripts.

# Define functions for each utility
function check_resources() {
    echo "=== System Resource Check ==="
    top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'
    free -h | awk '/Mem/ {print "Memory Usage: Used: " $3 " / Total: " $2}'
    df -h | awk '$NF=="/"{printf "Disk Usage: %s / %s (%s)\n", $3, $2, $5}'
    echo
}

function check_permissions() {
    echo "=== Permission Troubleshooter ==="
    read -p "Enter the file/directory path to check: " TARGET
    if [ -e "$TARGET" ]; then
        ls -ld "$TARGET"
        echo "Owner: $(stat -c %U "$TARGET")"
        echo "Group: $(stat -c %G "$TARGET")"
        echo "Current user: $(whoami)"
    else
        echo "Target not found."
    fi
    echo
}

function check_network() {
    echo "=== Network Diagnostics ==="
    ping -c 4 google.com &> /dev/null && echo "Internet: Connected" || echo "Internet: Not Connected"
    curl -s ifconfig.me && echo "Public IP retrieved successfully." || echo "Unable to fetch public IP."
    ip -brief addr
    echo
}

function clean_temp_files() {
    echo "=== Temp File Cleaner ==="
    sudo rm -rf /tmp/* ~/.cache/*
    echo "Temporary files cleaned!"
    echo
}

function fix_symlinks() {
    echo "=== Broken Symlink Fixer ==="
    read -p "Enter the directory to search for broken symlinks (default: current directory): " TARGET
    TARGET=${TARGET:-$(pwd)}
    find "$TARGET" -xtype l -exec rm -i {} \;
    echo "Broken symlinks fixed."
    echo
}

function kill_zombies() {
    echo "=== Zombie Process Killer ==="
    zombies=$(ps aux | awk '{ if ($8 == "Z") print $2 }')
    if [ -z "$zombies" ]; then
        echo "No zombie processes found."
    else
        echo "Found zombie processes: $zombies"
        echo "$zombies" | xargs sudo kill -9
        echo "Zombie processes killed."
    fi
    echo
}

function disk_cleanup() {
    echo "=== Disk Space Cleaner ==="
    read -p "Enter the directory to clean (default: /): " TARGET
    TARGET=${TARGET:-/}
    echo "Finding large files (>100MB)..."
    find "$TARGET" -type f -size +100M -exec du -h {} + | sort -rh | head -10
    echo "Finding unnecessary logs..."
    find "$TARGET" -type f -name "*.log" -size +10M -exec ls -lh {} \;
    echo
}

function update_system() {
    echo "=== System Update ==="
    sudo apt update && sudo apt upgrade -y
    sudo apt autoremove -y && sudo apt autoclean
    echo "System updated and cleaned!"
    echo
}

function backup_folder() {
    echo "=== Backup Folder ==="
    read -p "Enter the folder to back up: " SOURCE
    if [ ! -d "$SOURCE" ]; then
        echo "Error: Folder does not exist."
        return
    fi
    BACKUP_DIR="$HOME/Backups"
    mkdir -p "$BACKUP_DIR"
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    BACKUP_FILE="$BACKUP_DIR/$(basename "$SOURCE")_$TIMESTAMP.tar.gz"
    tar -czf "$BACKUP_FILE" "$SOURCE"
    echo "Backup created: $BACKUP_FILE"
    echo
}

function revert_permissions() {
    echo "=== Revert Permissions ==="
    read -p "Enter the directory to revert permissions (default: current directory): " TARGET
    TARGET=${TARGET:-$(pwd)}
    find "$TARGET" -type d -exec chmod 755 {} \;
    find "$TARGET" -type f -exec chmod 644 {} \;
    echo "Permissions reverted to defaults."
    echo
}

# Main menu
while true; do
    echo "=== Troubleshooter Menu ==="
    echo "1. Check System Resources"
    echo "2. Check File/Directory Permissions"
    echo "3. Check Network Connectivity"
    echo "4. Clean Temporary Files"
    echo "5. Fix Broken Symlinks"
    echo "6. Kill Zombie Processes"
    echo "7. Disk Space Cleaner"
    echo "8. Update System"
    echo "9. Backup Folder"
    echo "10. Revert Permissions"
    echo "11. Exit"
    echo
    read -p "Choose an option: " CHOICE

    case $CHOICE in
        1) check_resources ;;
        2) check_permissions ;;
        3) check_network ;;
        4) clean_temp_files ;;
        5) fix_symlinks ;;
        6) kill_zombies ;;
        7) disk_cleanup ;;
        8) update_system ;;
        9) backup_folder ;;
        10) revert_permissions ;;
        11) echo "Exiting. Goodbye!" ; exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done

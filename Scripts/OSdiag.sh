#!/bin/bash
# os_troubleshoot.sh
# Consolidated troubleshooting script for OS-level issues

echo "=== OS Troubleshooting Script ==="

# Function: Check system resources
check_resources() {
    echo "Checking System Resources..."
    echo "CPU Usage:"
    top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'
    
    echo "Memory Usage:"
    free -h | awk '/Mem/ {print "Used: " $3 " / Total: " $2}'
    
    echo "Disk Usage:"
    df -h | awk '$NF=="/"{printf "Disk Usage: %s / %s (%s)\n", $3, $2, $5}'
}

# Function: Check permissions for a file or directory
check_permissions() {
    read -p "Enter the file/directory path to check: " TARGET
    if [ -e "$TARGET" ]; then
        echo "Permissions for $TARGET:"
        ls -ld "$TARGET"
        echo "Owner: $(stat -c %U "$TARGET")"
        echo "Group: $(stat -c %G "$TARGET")"
        echo "Current user: $(whoami)"
    else
        echo "Target not found."
    fi
}

# Function: Check network connectivity
check_network() {
    echo "Checking Network Connectivity..."
    echo "Pinging Google..."
    if ping -c 4 google.com &> /dev/null; then
        echo "Internet: Connected"
    else
        echo "Internet: Not Connected"
    fi

    echo "Fetching public IP address..."
    curl -s ifconfig.me || echo "Unable to fetch public IP"

    echo "Active network interfaces:"
    ip -brief addr
}

# Function: Check a system service
check_service() {
    read -p "Enter the service name to check: " SERVICE
    echo "Checking service status..."
    if systemctl is-active "$SERVICE" &> /dev/null; then
        echo "$SERVICE is active."
    else
        echo "$SERVICE is not active."
    fi

    echo "Checking service logs..."
    journalctl -u "$SERVICE" --since today || echo "No logs found for $SERVICE."
}

# Main menu
while true; do
    echo
    echo "Select an option:"
    echo "1. Check System Resources"
    echo "2. Check File/Directory Permissions"
    echo "3. Check Network Connectivity"
    echo "4. Check a System Service"
    echo "5. Exit"
    read -p "Enter your choice: " CHOICE

    case $CHOICE in
        1)
            check_resources
            ;;
        2)
            check_permissions
            ;;
        3)
            check_network
            ;;
        4)
            check_service
            ;;
        5)
            echo "Exiting OS Troubleshooting Script. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done

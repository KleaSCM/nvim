#!/bin/bash
# setup_go_project.sh
# Installs Go, sets up the environment, and creates a new Go project.

# Function to install Go
install_go() {
    echo "Checking for Go installation..."
    if ! command -v go &> /dev/null; then
        echo "Go is not installed. Installing Go..."
        wget https://go.dev/dl/go1.21.0.linux-amd64.tar.gz -O /tmp/go.tar.gz
        sudo tar -C /usr/local -xzf /tmp/go.tar.gz
        echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
        source ~/.bashrc
        rm /tmp/go.tar.gz
        echo "Go installed successfully."
    else
        echo "Go is already installed."
    fi
}

# Function to set up a Go project
setup_project() {
    echo "Enter your new Go project name: "
    read -r PROJECT_NAME

    if [ -z "$PROJECT_NAME" ]; then
        echo "Project name cannot be empty. Exiting."
        exit 1
    fi

    PROJECT_DIR="$HOME/Documents/Go/$PROJECT_NAME"

    if [ -d "$PROJECT_DIR" ]; then
        echo "A project with this name already exists in $PROJECT_DIR."
        exit 1
    fi

    echo "Creating project directory at $PROJECT_DIR..."
    mkdir -p "$PROJECT_DIR"
    cd "$PROJECT_DIR" || exit

    echo "Initializing Go module..."
    go mod init "$PROJECT_NAME"

    echo "Creating main.go..."
    cat > main.go <<EOF
package main

import "fmt"

func main() {
    fmt.Println("Welcome to $PROJECT_NAME!")
}
EOF

    echo "Setting up basic README.md..."
    cat > README.md <<EOF
# $PROJECT_NAME

A new Go project created using the setup script.

## How to Run

1. Install dependencies:
   \`\`\`bash
   go mod tidy
   \`\`\`

2. Run the application:
   \`\`\`bash
   go run main.go
   \`\`\`
EOF

    echo "Go project $PROJECT_NAME has been set up in $PROJECT_DIR."
}

# Main script execution
echo "Setting up your Go development environment..."
install_go
setup_project

echo "Setup comolete ✅"

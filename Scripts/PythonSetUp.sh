#!/bin/bash
# setup_python_project.sh
# Sets up a new Python project in ~/Documents/PythonProjects/

# Function to set up a Python project
setup_python_project() {
    echo "Enter your new Python project name: "
    read -r PROJECT_NAME

    if [ -z "$PROJECT_NAME" ]; then
        echo "Project name cannot be empty. Exiting."
        exit 1
    fi

    PROJECT_DIR="$HOME/Documents/PythonProjects/$PROJECT_NAME"

    if [ -d "$PROJECT_DIR" ]; then
        echo "A project with this name already exists in $PROJECT_DIR."
        exit 1
    fi

    echo "Creating project directory at $PROJECT_DIR..."
    mkdir -p "$PROJECT_DIR"
    cd "$PROJECT_DIR" || exit

    echo "Setting up virtual environment..."
    python3 -m venv venv
    source venv/bin/activate

    echo "Creating main.py..."
    cat > main.py <<EOF
# $PROJECT_NAME - Main Entry Point

def main():
    print("Welcome to $PROJECT_NAME!")

if __name__ == "__main__":
    main()
EOF

    echo "Setting up basic README.md..."
    cat > README.md <<EOF
# $PROJECT_NAME

A new Python project created using the setup script.

## How to Run

1. Activate the virtual environment:
   \`\`\`bash
   source venv/bin/activate
   \`\`\`

2. Run the application:
   \`\`\`bash
   python main.py
   \`\`\`
EOF

    echo "Python project $PROJECT_NAME has been set up in $PROJECT_DIR."
    deactivate
}

# Main script execution
echo "Setting up your Python project environment..."
setup_python_project
echo "Setup complete!"

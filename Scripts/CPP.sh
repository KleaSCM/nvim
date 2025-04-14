#!/bin/bash
# setup_cpp_project.sh
# Sets up a basic C++ project with CMake

# Prompt for project name
echo "Enter your new C++ project name: "
read -r PROJECT_NAME

if [ -z "$PROJECT_NAME" ]; then
    echo "Project name cannot be empty. Exiting."
    exit 1
fi

# Define project directory
PROJECT_DIR="$HOME/Documents/CPPProjects/$PROJECT_NAME"

if [ -d "$PROJECT_DIR" ]; then
    echo "A project with this name already exists in $PROJECT_DIR."
    exit 1
fi

# Create project structure
echo "Creating project directory at $PROJECT_DIR..."
mkdir -p "$PROJECT_DIR/src" "$PROJECT_DIR/include" "$PROJECT_DIR/build"

# Create main.cpp
cat > "$PROJECT_DIR/src/main.cpp" <<EOF
#include <iostream>

int main() {
    std::cout << "Welcome to $PROJECT_NAME!" << std::endl;
    return 0;
}
EOF

# Create CMakeLists.txt
cat > "$PROJECT_DIR/CMakeLists.txt" <<EOF
cmake_minimum_required(VERSION 3.20)
project($PROJECT_NAME)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Add the source directory
add_executable($PROJECT_NAME src/main.cpp)
EOF

# Create README.md
cat > "$PROJECT_DIR/README.md" <<EOF
# $PROJECT_NAME

A new C++ project created using the setup script.

## Build Instructions

1. Create the build directory:
   \`\`\`bash
   mkdir -p build
   cd build
   \`\`\`

2. Run CMake:
   \`\`\`bash
   cmake ..
   \`\`\`

3. Build the project:
   \`\`\`bash
   make
   \`\`\`

4. Run the application:
   \`\`\`bash
   ./${PROJECT_NAME}
   \`\`\`
EOF

# Optionally initialize a Git repository
echo "Do you want to initialize a Git repository? (y/n): "
read -r INIT_GIT

if [ "$INIT_GIT" = "y" ]; then
    cd "$PROJECT_DIR" || exit
    git init
    echo "build/" > .gitignore
    git add .
    git commit -m "Initial commit for $PROJECT_NAME"
    echo "Git repository initialized."
fi

echo "C++ project $PROJECT_NAME has been set up in $PROJECT_DIR."

# Optionally open in VS Code
if command -v code &> /dev/null; then
    echo "Opening $PROJECT_DIR in VS Code..."
    code "$PROJECT_DIR"
else
    echo "open in editor."
fi

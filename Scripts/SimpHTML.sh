#!/bin/bash
# setup_html_project.sh
# Sets up an HTML boilerplate with a custom project name.

# Prompt for project name
echo "Enter your new HTML project name: "
read -r PROJECT_NAME

if [ -z "$PROJECT_NAME" ]; then
    echo "Project name cannot be empty. Exiting."
    exit 1
fi

# Set up project directory
PROJECT_DIR="$HOME/Documents/HTMLProjects/$PROJECT_NAME"

if [ -d "$PROJECT_DIR" ]; then
    echo "A project with this name already exists in $PROJECT_DIR."
    exit 1
fi

echo "Creating project directory at $PROJECT_DIR..."
mkdir -p "$PROJECT_DIR"

# Create HTML boilerplate
cat > "$PROJECT_DIR/index.html" <<EOF
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$PROJECT_NAME</title>
  <link rel="stylesheet" href="styles.css">
  <script src="script.js" defer></script>
</head>

<body>
  <!-- Main container to start coding -->
  <div id="app">
    <!-- Start coding here -->
  </div>
</body>

</html>
EOF

# Create CSS boilerplate
cat > "$PROJECT_DIR/styles.css" <<EOF
/* styles.css */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    background-color: #f4f4f9;
    color: #333;
}

#app {
    padding: 20px;
    max-width: 1200px;
    margin: auto;
}
EOF

# Create JavaScript boilerplate
cat > "$PROJECT_DIR/script.js" <<EOF
// script.js
document.addEventListener("DOMContentLoaded", () => {
    const app = document.getElementById("app");
    console.log("Welcome to $PROJECT_NAME!");
});
EOF

echo "HTML project $PROJECT_NAME has been set up in $PROJECT_DIR."

# Optionally, open the directory in VS Code or any editor
if command -v code &> /dev/null; then
    echo "Opening $PROJECT_DIR in VS Code..."
    code "$PROJECT_DIR"
else
    echo "open the project in your preferred editor."
fi

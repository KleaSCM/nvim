#!/bin/bash
# setup_flask_project.sh
# Sets up a new Flask project in ~/Documents/PythonProjects/

# Function to set up a Flask project
setup_flask_project() {
    echo "Enter your new Flask project name: "
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

    echo "Installing Flask..."
    pip install flask

    echo "Creating Flask app files..."
    mkdir -p app/templates app/static
    cat > app/__init__.py <<EOF
from flask import Flask

def create_app():
    app = Flask(__name__)

    @app.route("/")
    def home():
        return "Welcome to $PROJECT_NAME!"

    return app
EOF

    cat > run.py <<EOF
from app import create_app

app = create_app()

if __name__ == "__main__":
    app.run(debug=True)
EOF

    echo "Setting up basic README.md..."
    cat > README.md <<EOF
# $PROJECT_NAME

A Flask web application created using the setup script.

## How to Run

1. Activate the virtual environment:
   \`\`\`bash
   source venv/bin/activate
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   pip install -r requirements.txt
   \`\`\`

3. Run the application:
   \`\`\`bash
   python run.py
   \`\`\`

## Project Structure
\`\`\`
$PROJECT_NAME/
├── app/
│   ├── __init__.py
│   ├── templates/
│   ├── static/
├── run.py
├── venv/
├── README.md
\`\`\`
EOF

    echo "Exporting dependencies to requirements.txt..."
    pip freeze > requirements.txt

    echo "Flask project $PROJECT_NAME has been set up in $PROJECT_DIR."
    deactivate
}

# Main script execution
echo "Setting up your Flask project environment..."
setup_flask_project
echo "Setup complete"

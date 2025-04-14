#!/bin/bash
# setup_sqlite_db.sh
# Sets up a SQLite database with a basic schema.

# Prompt for database name
echo "Enter your SQLite database name (without extension): "
read -r DB_NAME

if [ -z "$DB_NAME" ]; then
    echo "Database name cannot be empty. Exiting."
    exit 1
fi

# Define the database file path
DB_DIR="$HOME/Documents/SQLiteDBs"
DB_FILE="$DB_DIR/$DB_NAME.db"

# Create directory for SQLite databases
mkdir -p "$DB_DIR"

# Check if the database already exists
if [ -f "$DB_FILE" ]; then
    echo "A database with this name already exists at $DB_FILE."
    exit 1
fi

# Create the database
echo "Creating SQLite database at $DB_FILE..."
sqlite3 "$DB_FILE" <<EOF
-- Create a sample table
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Insert a sample user
INSERT INTO users (name, email) VALUES ('John Doe', 'john.doe@example.com');

-- Display the table schema
.schema users

-- Display sample data
SELECT * FROM users;
EOF

# Generate an optional SQL script file for future modifications
SQL_SCRIPT="$DB_DIR/$DB_NAME_setup.sql"
cat > "$SQL_SCRIPT" <<EOF
-- Add additional tables, indices, or changes here.
-- Example:
-- CREATE TABLE IF NOT EXISTS orders (
--     id INTEGER PRIMARY KEY AUTOINCREMENT,
--     user_id INTEGER NOT NULL,
--     total_amount REAL NOT NULL,
--     created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
--     FOREIGN KEY (user_id) REFERENCES users (id)
-- );

-- Example for inserting sample data:
-- INSERT INTO orders (user_id, total_amount) VALUES (1, 99.99);
EOF

echo "SQLite database setup complete!"
echo "Database file: $DB_FILE"
echo "SQL script for modifications: $SQL_SCRIPT"

# Optionally open the database in a SQLite browser (if installed)
if command -v sqlitebrowser &> /dev/null; then
    echo "Opening the database in SQLite Browser..."
    sqlitebrowser "$DB_FILE"
else
    echo "You can open the database in your preferred SQLite editor."
fi

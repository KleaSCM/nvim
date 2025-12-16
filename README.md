# Neovim Configuration

Fully configured Neovim setup

## Features

### Aesthetic
- Clean, minimal interface with soft colors
- Custom notifications and UI elements

### Session Management
- **Auto-session**: Automatic session saving and restoration
- **Persistence**: Smart session management with project-specific sessions
- **Project Integration**: Seamless project-based session handling

### Key Features
- Project detection and management
- Telescope integration for fuzzy finding
- Auto-save functionality
- Session persistence across restarts

## Key Mappings

### Session Management
- `<leader>sl` - Search sessions
- `<leader>ss` - Save current session
- `<leader>sr` - Restore session
- `<leader>sd` - Delete session

### Project Sessions
- `<leader>ps` - Save project session
- `<leader>pr` - Restore project session

## Installation

1. Backup your existing Neovim configuration:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. Clone this configuration:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

3. Open Neovim and let the plugins install:
   ```bash
   nvim
   ```

## Configuration

### Session Management
Sessions are automatically:
- Saved when exiting Neovim
- Saved every 5 minutes
- Restored on startup (if no arguments provided)
- Managed per-project for better organization

### Project Detection
Projects are automatically detected by the presence of:
- `.git` directory
- `Makefile`
- `package.json`
- Other version control files

## Structure

```
~/.config/nvim/
├── lua/
│   ├── plugins/
│   │   └── sessions.lua    # Session management configuration
│   └── ...
├── README.md
└── ...
```

## Dependencies

- Neovim 0.7+
- Git
- Telescope.nvim
- project.nvim
- persistence.nvim
- auto-session.nvim

## Customization

Feel free to modify the configuration to suit your preferences. The main session management logic is in `lua/plugins/sessions.lua`.

## Troubleshooting

If you encounter issues:
1. Check that all dependencies are installed
2. Ensure Neovim is up to date
3. Remove the `sessions.lua` plugin temporarily to isolate issues
4. Check the plugin directories in `~/.local/share/nvim/lazy/`

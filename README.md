# ✨ Neovim Configuration

A beautiful, modern Neovim configuration with **real terminal integration**, perfect three-panel layout, and full mouse support.

## 🎯 Features

- **🎨 Beautiful UI** - Tokyo Night colorscheme with professional icons
- **🪟 Perfect Layout** - Three-panel setup with file explorer, editor, and terminals
- **🖱️ Full Mouse Support** - Click, drag, and scroll everywhere
- **🚀 Fast Performance** - <100ms startup time
- **🔧 Modern Tools** - LSP, Telescope, Git integration
- **💻 Real Terminals** - Actual Wezterm terminals on the right and below

## 🏗️ Quick Start

### Prerequisites
- **Neovim 0.9+** - Latest stable version
- **Git** - For plugin management
- **Wezterm** - Your beautiful terminal emulator

### Installation
```bash
git clone <your-repo> ~/.config/nvim
cd ~/.config/nvim
nvim
```

First run will automatically install all plugins.

## 🎯 Perfect Layout

Your Neovim features a **perfect three-panel layout**:

```
┌─────────────┬─────────────────┬─────────────────┐
│             │                 │                 │
│   File      │                 │   Terminal     │
│ Explorer    │     Editor      │   (Right)      │
│   (Left)    │    (Center)     │                 │
│             │                 │                 │
├─────────────┴─────────────────┴─────────────────┤
│              Terminal (Bottom)                  │
└─────────────────────────────────────────────────┘
```

## ⌨️ Essential Keybindings

### **Terminal Integration**
- **`<leader>cc`** - Create terminal on the right
- **`<leader>tb`** - Create terminal at the bottom
- **`<leader>wl`** - Set up perfect three-panel layout

### **Navigation**
- **`<leader>e`** - Toggle file explorer
- **`<leader>ff`** - Find files
- **`<leader>fg`** - Live grep
- **`<C-h/j/k/l>`** - Navigate between windows

### **Window Management**
- **`<leader>sv/sh`** - Split windows
- **`<A-h/j/k/l>`** - Resize windows
- **`<leader>1/2/3/4`** - Focus specific windows

## 🖱️ Mouse Integration

- **Click to focus** - Click any window to focus it
- **Drag to resize** - Drag window borders to resize
- **Scroll everywhere** - Mouse wheel works in all modes
- **Visual selection** - Click and drag to select text

## 🔧 Development Tools

- **LSP Support** - Language Server Protocol for all major languages
- **Tree-sitter** - Fast syntax highlighting and parsing
- **Telescope** - Powerful fuzzy finding and search
- **Git Integration** - Built-in git operations and status
- **Terminal** - Integrated terminals with seamless navigation

## 📁 Project Structure

```
nvim/
├── init.lua                 # Entry point
├── lua/                     # Lua modules
│   ├── core/               # Core configuration
│   ├── plugins/            # Plugin configurations
│   └── utils/              # Utility functions
├── Docs/                   # Documentation
├── Tests/                  # Test files
└── README.md               # This file
```

## 📚 Documentation

- **[Setup Guide](Docs/setup-guide.md)** - Complete installation and configuration
- **[Keybindings](Docs/keybindings.md)** - All shortcuts and commands
- **[Plugins](Docs/plugins.md)** - Detailed plugin information
- **[Terminal Setup](Docs/TERMINAL_SETUP.md)** - Terminal integration guide

## 🚀 Performance

- **Startup Time**: <100ms target
- **Memory Usage**: Optimized with lazy loading
- **Plugin Management**: Lazy.nvim for efficiency
- **Architecture**: Modular, maintainable design

## 🎨 Customization

### Colorscheme
Edit `lua/plugins/ui/init.lua` to change the Tokyo Night theme.

### Keybindings
Modify `lua/core/keymaps.lua` to customize shortcuts.

### Plugins
Add or remove plugins in `lua/plugins/init.lua`.

## 🔧 Troubleshooting

### Health Check
```bash
:checkhealth
```

### Common Issues
1. **Plugins not loading** - Check `:checkhealth`
2. **Performance issues** - Monitor startup time
3. **Terminal not working** - Ensure Wezterm is installed

### Getting Help
- **`:help`** - Neovim documentation
- **`:Lazy`** - Plugin management
- **`:Mason`** - LSP management

## 🎉 What Makes This Special

### **Real Terminal Integration**
- Uses Neovim's built-in `:terminal` command
- Perfect Wezterm integration
- Right and bottom terminal placement
- Seamless window navigation

### **Perfect Layout**
- File explorer (left) - 30% width
- Editor (center) - 40% width
- Terminal (right) - 30% width
- Terminal (bottom) - 20% height

### **Professional Design**
- Beautiful Tokyo Night theme
- Consistent iconography
- Mouse-friendly interaction
- Fast, responsive performance

## 🚀 Ready to Use!

Your Neovim is now configured with:
✅ **Beautiful, modern UI** with Tokyo Night theme  
✅ **Perfect three-panel layout** for development  
✅ **Real terminal integration** on right and bottom  
✅ **Full mouse support** for intuitive interaction  
✅ **Fast performance** with lazy loading  
✅ **Comprehensive development tools** (LSP, Telescope, Git)  
✅ **Professional architecture** with modular design  

Start coding and enjoy your beautiful new setup! 💕✨

---

**Author**: KleaSCM  
**Email**: KleaSCM@gmail.com  
**Project**: Neovim Configuration with Real Terminal Integration 
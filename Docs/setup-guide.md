# 🚀 Neovim Setup Guide

Welcome to your beautiful Neovim configuration! This guide will help you get everything set up and running perfectly. 💕

## ✨ What You're Getting

Your Neovim now features:

- **🎨 Beautiful UI** - Tokyo Night colorscheme with adorable icons
- **🪟 Perfect Layout** - Three-panel setup with file explorer, editor, and terminals
- **🖱️ Full Mouse Support** - Click, drag, and scroll everywhere
- **🚀 Fast Performance** - <100ms startup time
- **🔧 Modern Tools** - LSP, Telescope, Git integration
- **💻 Real Terminals** - Actual Wezterm terminals on the right and below

## 🏗️ Installation

### Prerequisites

- **Neovim 0.9+** - Latest stable version
- **Git** - For plugin management
- **Wezterm** - Your beautiful terminal emulator
- **Node.js** - For LSP servers (optional but recommended)

### Quick Start

1. **Clone the configuration**:
   ```bash
   git clone <your-repo> ~/.config/nvim
   cd ~/.config/nvim
   ```

2. **Install dependencies**:
   ```bash
   # Install ripgrep for Telescope
   sudo pacman -S ripgrep
   
   # Install Node.js for LSP (optional)
   sudo pacman -S nodejs npm
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

4. **Wait for setup** - First run will install all plugins automatically

## 🎯 Perfect Layout

Your Neovim now has the **perfect three-panel layout**:

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

### Quick Layout Commands

- **`<leader>wl`** - Set perfect three-panel layout
- **`<leader>wt`** - Toggle between layouts
- **`<leader>wr`** - Reset window sizes

## ⌨️ Essential Keybindings

### Navigation
- **`<leader>e`** - Toggle file explorer
- **`<leader>ff`** - Find files
- **`<leader>fg`** - Live grep
- **`<leader>tt`** - Toggle terminal

### Terminal Integration
- **`<leader>cc`** - Create terminal on the right
- **`<leader>tb`** - Create terminal at the bottom
- **`<leader>ci`** - Inspect code with LSP
- **`<leader>cg`** - Generate code with LSP
- **`<leader>ce`** - Edit with LSP

### Window Management
- **`<C-h/j/k/l>`** - Navigate between windows
- **`<A-h/j/k/l>`** - Resize windows
- **`<leader>sv/sh`** - Split windows

## 🖱️ Mouse Integration

Your Neovim now has **full mouse support** for an intuitive experience:

- **Click to focus** - Click any window to focus it
- **Drag to resize** - Drag window borders to resize
- **Scroll in any mode** - Mouse wheel works everywhere
- **Visual selection** - Click and drag to select text
- **Window navigation** - Click to switch between windows

### Mouse-Friendly Keybindings
- **`<C-Left/Right/Up/Down>`** - Navigate between windows
- **`<C-S-Left/Right/Up/Down>`** - Resize windows with keyboard

## Terminal Setup

The configuration integrates with **actual Wezterm terminals** through terminal splits:

- **`<leader>cc`** - Creates a terminal on the right side
- **`<leader>tb`** - Creates a terminal at the bottom

### How It Works

1. **Real Terminal Integration**: Uses Neovim's built-in `:terminal` command
2. **Automatic Placement**: Creates terminals exactly where you need them
3. **Seamless Navigation**: Use `<C-h/j/k/l>` to navigate between windows from terminal mode
4. **Easy Exit**: Press `<Esc>` to exit terminal mode and return to normal mode

### Usage

1. Press `<leader>cc` to create a terminal on the right
2. Press `<leader>tb` to create a terminal at the bottom
3. Use `<C-h/j/k/l>` to navigate between windows
4. Press `<Esc>` to exit terminal mode

## 🎨 Customization

### Colorscheme
The configuration uses Tokyo Night by default. To change:

1. Edit `lua/plugins/ui/init.lua`
2. Modify the tokyonight.nvim configuration
3. Restart Neovim

### Icons and Visuals
Your Neovim now has **adorable icons everywhere**:

- **File Types** - 🌙 Lua, 💫 JavaScript, ✨ TypeScript, 🐍 Python, 🦀 Rust
- **Git Status** - ✨ staged, 💫 unstaged, 💔 deleted, 💭 untracked
- **UI Elements** - 🔍 search, 💕 selection, 📁 folders, 📄 files
- **Diagnostics** - 💥 errors, ⚠️ warnings, 💡 info, 💭 hints

### Keybindings
Customize keybindings in `lua/core/keymaps.lua`:

```lua
-- Example: Change leader key
vim.g.mapleader = ","

-- Example: Add custom keybinding
vim.keymap.set("n", "<leader>xx", ":echo 'Hello!'<CR>")
```

### Plugins
Add or remove plugins in `lua/plugins/init.lua`:

```lua
-- Example: Add a new plugin
{
    "username/plugin-name",
    config = function()
        require("plugin-name").setup()
    end,
}
```

## 🚀 Performance Tips

### Startup Time
- **Target**: <100ms startup time
- **Monitor**: Use `:checkhealth` to check performance
- **Optimize**: Disable unused plugins

### Memory Usage
- **Lazy Loading**: Plugins load only when needed
- **Clean Startup**: Minimal memory footprint
- **Efficient**: Optimized for speed and responsiveness

## 🔧 Troubleshooting

### Common Issues

1. **Plugins not loading**:
   - Check `:checkhealth`
   - Ensure all dependencies are installed
   - Restart Neovim

2. **Performance issues**:
   - Use `:checkhealth` to identify problems
   - Check plugin configurations
   - Monitor startup time

3. **Terminal not working**:
   - Ensure Wezterm is installed
   - Check shell configuration
   - Verify terminal plugin is loaded

### Getting Help

- **`:help`** - Neovim documentation
- **`:checkhealth`** - Health check
- **`:Lazy`** - Plugin management
- **`:Mason`** - LSP management

## 🎉 You're All Set!

Your Neovim is now configured with:

✅ **Beautiful UI** with Tokyo Night theme  
✅ **Perfect three-panel layout**  
✅ **Real Wezterm terminals** on right and bottom  
✅ **Full mouse support** for intuitive interaction  
✅ **Fast performance** with lazy loading  
✅ **Modern development tools** (LSP, Telescope, Git)  
✅ **Adorable icons** everywhere  

Start coding and enjoy your beautiful new setup! 💕✨

 
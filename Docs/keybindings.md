# ⌨️ Keybindings Reference

This document provides a comprehensive reference for all the keybindings in our Neovim configuration.

## 🎯 Leader Key

Our leader key is set to **Space** (`<leader>`). All custom keybindings use this as a prefix.

## 🪟 Window Management

### Navigation
- `<C-h>` - Navigate to left window
- `<C-j>` - Navigate to down window  
- `<C-k>` - Navigate to up window
- `<C-l>` - Navigate to right window

### Resizing
- `<A-h>` - Resize window left
- `<A-j>` - Resize window down
- `<A-k>` - Resize window up
- `<A-l>` - Resize window right

### Mouse-Friendly Navigation
- `<C-Left>` - Navigate to left window
- `<C-Right>` - Navigate to right window
- `<C-Up>` - Navigate to up window
- `<C-Down>` - Navigate to down window

### Mouse-Friendly Resizing
- `<C-S-Left>` - Resize window left
- `<C-S-Right>` - Resize window right
- `<C-S-Up>` - Resize window up
- `<C-S-Down>` - Resize window down

### Splitting
- `<leader>sv` - Split vertically
- `<leader>sh` - Split horizontally
- `<leader>se` - Equalize window sizes
- `<leader>sx` - Close current window

### Layout Presets
- `<leader>wl` - Set default layout (File explorer left, Editor center, Terminal right)
- `<leader>wt` - Toggle between layouts
- `<leader>wr` - Reset window sizes

### Focus Management
- `<leader>1` - Focus window 1
- `<leader>2` - Focus window 2
- `<leader>3` - Focus window 3
- `<leader>4` - Focus window 4

## 📁 File Explorer (Nvim-tree)

- `<leader>e` - Toggle file explorer
- `<leader>ef` - Focus file explorer
- `<leader>ec` - Close file explorer

## 💻 Terminal Integration

- `<leader>tt` - Toggle terminal (horizontal)
- `<leader>tf` - Toggle floating terminal
- `<leader>th` - Toggle horizontal terminal
- `<leader>tv` - Toggle vertical terminal
- `<C-\>` - Quick terminal toggle (global)

## 🖥️ Right and Bottom Terminals

- **`<leader>cc`** - Create/focus **right terminal**
- **`<leader>tb`** - Create/focus **bottom terminal**

### Terminal Management
- **`<leader>tc`** - Close current window

### Terminal Navigation (when in terminal mode)
- **`<C-h>`** - Navigate left from terminal
- **`<C-j>`** - Navigate down from terminal  
- **`<C-k>`** - Navigate up from terminal
- **`<C-l>`** - Navigate right from terminal
- **`<Esc>`** - Exit terminal mode

### Perfect Layout Setup
- **`<leader>wl`** - Set up perfect three-panel layout with both terminals
  - Left: File explorer (30% width)
  - Center: Editor (40% width) 
  - Right: Terminal (30% width)
  - Bottom: Terminal (20% height)

## 🔍 Telescope (Fuzzy Finder)

- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Help tags
- `<leader>fr` - Recent files

## 📝 Buffer Management

- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer
- `<leader>bd` - Delete buffer
- `<leader>bl` - List buffers

## 🚀 LSP (Language Server Protocol)

- `gd` - Go to definition
- `gr` - Go to references
- `gi` - Go to implementation
- `K` - Hover documentation
- `<C-k>` - Signature help

### Code Actions
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>f` - Format code

## 🔧 Mason (LSP Management)

- `<leader>mm` - Open Mason (install/manage LSP servers)
- `<leader>ml` - Mason log
- `<leader>mu` - Update Mason packages

## 🐙 Git Integration

- `<leader>gs` - Git status
- `<leader>gc` - Git commit
- `<leader>gp` - Git push
- `<leader>gl` - Git log

## 💾 File Operations

- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>wq` - Save and quit

## 🔎 Search and Replace

- `<leader>s` - Search and replace
- `n` - Next search result (centered)
- `N` - Previous search result (centered)

## 📏 Indentation and Movement

- `<` - Indent left (visual mode)
- `>` - Indent right (visual mode)
- `<A-j>` - Move line down
- `<A-k>` - Move line up

## 🎯 Cursor Positioning

- `zz` - Center cursor
- `zt` - Top of screen
- `zb` - Bottom of screen

## 📱 Insert Mode Enhancements

- `j` - Move down (wrapped lines)
- `k` - Move up (wrapped lines)

## 🎨 Visual Mode

- `j` - Move down (wrapped lines)
- `k` - Move up (wrapped lines)

## 🖱️ Mouse Integration

### Mouse Support
- **Click to focus** - Click any window to focus it
- **Drag to resize** - Drag window borders to resize
- **Scroll in any mode** - Mouse wheel works everywhere
- **Visual selection** - Click and drag to select text
- **Window navigation** - Click to switch between windows

### Mouse Settings
- **`mouse = "a"`** - Mouse works in all modes
- **`mousemodel = "extend"`** - Mouse can extend selections
- **`mousefocus = true`** - Mouse can focus windows
- **`mousemoveevent = true`** - Mouse move events enabled

## 🖥️ Terminal Mode

- `<Esc>` - Exit terminal mode

## 🆘 Help and Information

- `<leader>li` - Show layout information
- `:help` - Neovim help
- `:checkhealth` - Health check

## 📱 Mode-Specific Keybindings

### Normal Mode
All the keybindings listed above work in normal mode.

### Visual Mode
- `<` and `>` - Indent selection
- `<A-j>` and `<A-k>` - Move selected lines

### Insert Mode
- Enhanced movement with wrapped lines

### Terminal Mode
- `<Esc>` to exit

## 🎨 Customization

To customize these keybindings, edit the `lua/core/keymaps.lua` file. The configuration is modular and easy to modify.

## 🚀 Tips for Efficient Usage

1. **Learn the leader key combinations** - They're organized logically by function
2. **Use window management shortcuts** - Navigate quickly between panes
3. **Master the layout presets** - `<leader>wl` gives you the perfect development setup
4. **Utilize terminal integration** - Create terminals exactly where you need them
5. **Practice Telescope shortcuts** - Fast file and text search
6. **Embrace mouse integration** - Click and drag for intuitive interaction

## 🔍 Finding Keybindings

- Use `:which-key` to see all available keybindings
- Check this document for quick reference
- Use `:help` for detailed Neovim documentation

---

*Happy coding with your beautiful Neovim setup! 💕* 
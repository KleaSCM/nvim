# <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&pause=1000&color=DD6387&center=true&vCenter=true&width=435&lines=Klea's+Neovim+Config+Nvim?+Kleavim?" alt="Typing SVG" />

![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Vim](https://img.shields.io/badge/VIM-019733?style=for-the-badge&logo=vim&logoColor=white)
![Kitty](https://img.shields.io/badge/Kitty-000000?style=for-the-badge&logo=kitty&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)
![Tree-sitter](https://img.shields.io/badge/Tree--sitter-000000?style=for-the-badge&logo=tree-sitter&logoColor=white)
![Lazy.nvim](https://img.shields.io/badge/Lazy.nvim-000000?style=for-the-badge&logo=lua&logoColor=white)
![Catppuccin](https://img.shields.io/badge/Catppuccin-000000?style=for-the-badge&logo=catppuccin&logoColor=white)

Welcome to a Neovim configuration so clean it could eat cake off /dev/null.

Dark theme, Catppuccin core, fuzzy everywhere, terminal inside terminal inside terminal like a Russian hacker.

Powered by lazy.nvim, written in Lua, driven by<img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&pause=1000&color=DD6387&center=true&vCenter=true&width=435&lines=caffeine" alt="Typing SVG" />.

## ✨ Features

🔌 Plugin management with lazy.nvim

🎨 Beautiful UI with catppuccin + lualine + bufferline

🧠 Treesitter-based syntax highlighting

🛠 LSP pre-configured (clangd, lua_ls, pyright, rust_analyzer, tsserver)

🔍 Fuzzy finding via telescope.nvim

🐞 DAP support with nvim-dap & nvim-dap-ui

🧹 Linting with nvim-lint & trouble.nvim

🖼 In-terminal image preview via image.nvim

🔭 Floating terminal(s) with toggleterm.nvim

🐚 Tmux integration

🧾 Dashboard with alpha-nvim

📜 Custom script launcher with Rofi-style prompt

🎨 Tailwind & highlight color visualization

🧩 Modular structure
---
## 📦 Plugin Setup (via lazy.nvim)

```bash
# Clone Neovim config
cd ~/.config
git clone <this-repo> nvim

# Launch Neovim (lazy.nvim will bootstrap itself)
nvim
```
### After Neovim launches, run these commands:

```vim
:TSUpdate       " Install/update treesitter parsers
:MasonInstall   " Install missing LSPs
```
---
# 🗂 Structure

```bash
~/.config/nvim/
├── init.lua
└── lua/core/
    ├── core.lua         # Base plugins
    ├── leader.lua       # Space is leader
    ├── options.lua      # Editor behavior
    ├── keymaps.lua      # Keybindings galore
    ├── lazy.lua         # Plugin loader
    ├── terminal.lua     # ToggleTerm + LazyGit
    ├── tmux.lua         # Tmux navigator
    ├── treesitter.lua   # Parser config
    ├── ui.lua           # Catppuccin + Lualine + Bufferline
    └── ...
```
---
# 🎮 Keybindings Cheat Sheet

| Mode | Key | Description |
|------|-----|-------------|
| `n` | `<leader>e` | 🗂 Toggle file explorer |
| `n` | `<leader>ff` | 🔍 Telescope find files |
| `n` | `<leader>fg` | 🔎 Telescope live grep |
| `n` | `<leader>t` | 💻 Toggle terminal |
| `n` | `<leader>g` | 🐙 Launch LazyGit |
| `n` | `<S-q>` | ❌ Close buffer |
| `n` | `<F5>` | 🐞 DAP Continue |
| `n` | `<leader>xx` | ⚠️ Toggle Trouble.nvim |
| `n` | `<leader>s` | 🚀 Launch script picker |

Plus:
- <C-h/j/k/l> window movement
- <C-s> save (normal & insert)
- <C-q> quit
- <C-a> select all
---
# 📸 Dashboard
Custom alpha-nvim dashboard with ASCII banner,

buttons for file explorer, recent files, config, keymaps, and more. Pops up on empty start and when all buffers close.

---
# 🐛 Debugging (DAP)
- <F5> Start/Continue
- <F10> Step Over
- <F11> Step Into
- <F12> Step Out
- <leader>b Toggle breakpoint
- <leader>B Conditional breakpoint
- <leader>dr Open REPL
- <leader>dl Run last

<img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&pause=1000&color=DD6387&center=true&vCenter=true&width=435&lines=Auto+opens+dapui%2C+closes+cleanly." alt="Typing SVG" />

---
# 🧪 Linting & Diagnostics

ESLint, flake8, mypy, shellcheck, stylelint, markdownlint, luacheck, etc.

Diagnostics piped to trouble.nvim

- <leader>xx to toggle
- <leader>l to manually trigger linting
---
# 📸 Script Runner
### Custom script launcher in scripts.lua
- Find .sh scripts under Scripts/<category>/
- Prompt-based category + script selection
- Executes in a floating window
- Output shown with header & formatting
Launch with <leader>s 🧙‍♀️
---
# 🧠 Memory Cheats
- Autoformat on save (via LSP)
- Diagnostic icons + inline text
- Highlighted color hex codes (tailwind-friendly)
- Transparent & animated floating UIs (via noice.nvim)
---
# 🧪 Requirements
- Neovim 0.9+
- ripgrep (for Telescope)
- fd (optional but nice)
- Nerd Font (for icons)
- Terminal support for kitty/ueberzug if using image preview
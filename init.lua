--[[
 * Neovim Configuration (De-LazyVim Edition)
 *
 * Bootstrapped with mini.deps
 *
 * Author: KleaSCM
 * Email: KleaSCM@gmail.com
 ]]

-- Clone 'mini.nvim' manually in a reachable path
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing " | redraw')
  local clone_cmd = {
    "git", "clone", "--filter=blob:none",
    "https://github.com/echasnovski/mini.nvim", mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed " | redraw')
end

-- Set up 'mini.deps' (part of mini.nvim)
require("mini.deps").setup({ path = { package = path_package } })

-- Set Leader Key (MUST be before any keymaps)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core Config
require("config.Options")
require("config.Keymaps")
require("config.Autocmds")

-- Plugin Modules
require("plugins.Theme")
require("plugins.Dashboard")
require("plugins.UI")
require("plugins.Telescope")
require("plugins.Terminal")
require("plugins.NeoTree")
require("plugins.LSP")
require("plugins.AI")
require("plugins.Git")
require("plugins.WhichKey")
require("plugins.Gitsigns")
require("plugins.Diagnostics")

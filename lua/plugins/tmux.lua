return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    config = function()

    end,
  },
  {
    "tmux-plugins/vim-tmux",
    lazy = false,
    config = function()
      -- Basic tmux integration settings
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_save_on_switch = 1
      vim.g.tmux_navigator_disable_when_zoomed = 1

      -- Keybindings for tmux navigation
      vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
      vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
      vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
      vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })
    end,
  },
} 
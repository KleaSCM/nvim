local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Dashboard
  { import = "plugins.core" },
  -- Core plugins
  { import = "plugins.lsp" },
  { import = "plugins.cmp" },
  -- Treesitter
  { import = "plugins.treesitter" },
  -- UI and appearance
  { import = "plugins.ui" },
  -- Git integration
  { import = "plugins.git" },
  -- Fuzzy finder
  { import = "plugins.telescope" },
  -- Commenting
  { import = "plugins.comment" },
  -- Terminal integration
  { import = "plugins.terminal" },
  -- Image support
  { import = "plugins.image" },
  -- Linting and diagnostics
  { import = "plugins.linting" },
  -- Diagnostics and notifications
  { import = "plugins.diagnostics" },
}, {
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🔍",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
}) 
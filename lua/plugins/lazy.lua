return {
  {
    "folke/lazy.nvim",
    version = "*",
    lazy = false,
    priority = 10000,
    config = function()
      require("lazy").setup({
        spec = {
          { import = "plugins" },
        },
        defaults = {
          lazy = false,
          version = false,
        },
        install = { colorscheme = { "tokyonight", "habamax" } },
        checker = { enabled = true },
        performance = {
          rtp = {
            disabled_plugins = {
              "gzip",
              "matchit",
              "matchparen",
              "netrwPlugin",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })
    end,
  },
} 
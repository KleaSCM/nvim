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
          {
            dir = "~/.config/nvim",
            name = "scripts",
            config = function()
              require("plugins.scripts").setup()
            end,
            event = "VimEnter",
            priority = 1000,
            dependencies = { "goolord/alpha-nvim" },
            enabled = true,
          },
        },
        defaults = {
          lazy = true,
          version = false,
        },
        ui = {
          border = "rounded",
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
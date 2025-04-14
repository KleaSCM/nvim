return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
      })

      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")

      -- Telescope keymaps
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
      vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume Last Search" })
      vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "Find Recent Files" })
      vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Find Commands" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
    end,
  },
} 
-- Smart list management with feminine styling
return {
  {
    "gaoDean/autolist.nvim",
    event = "VeryLazy",
    config = function()
      require("autolist").setup({
        -- Default enabled filetypes
        enabled = true,
        filetype_map = {
          markdown = true,
          text = true,
          tex = true,
          plaintex = true,
          norg = true,
          org = true,
          rmd = true,
          quarto = true,
        },
        -- List characters
        lists = {
          -- Unordered lists
          unordered = {
            "*",
            "-",
            "+",
            "•",
            "◦",
            "‣",
            "⁃",
            "∗",
            "·",
          },
          -- Ordered lists
          ordered = {
            "1.",
            "2.",
            "3.",
            "a.",
            "b.",
            "c.",
            "i.",
            "ii.",
            "iii.",
            "I.",
            "II.",
            "III.",
          },
        },
        -- Feminine bullet points
        fancy_bullets = {
          "🌸",
          "💕",
          "✨",
          "💖",
          "🌺",
          "🌷",
          "💗",
          "🦄",
          "🌈",
          "🎀",
        },
        -- Auto formatting
        auto_format = true,
        -- Cycle through list types
        cycle = {
          "*",
          "-",
          "+",
          "•",
          "🌸",
          "💕",
          "✨",
        },
        -- Indentation
        indent_size = 2,
        -- Checkbox support
        checkbox = {
          checked = "✅",
          unchecked = "⬜",
          partial = "🔄",
        },
      })

      -- Set up keymaps for list management
      local function setup_autolist_keymaps()
        -- List navigation
        vim.keymap.set("n", "<CR>", "<cmd>AutolistNewBullet<CR>", { desc = "New list item" })
        vim.keymap.set("n", "o", "<cmd>AutolistNewBullet<CR>", { desc = "New list item below" })
        vim.keymap.set("n", "O", "<cmd>AutolistNewBulletBefore<CR>", { desc = "New list item above" })
        
        -- List toggling
        vim.keymap.set("n", "<leader>lt", "<cmd>AutolistToggleCycle<CR>", { desc = "Toggle list type" })
        vim.keymap.set("n", "<leader>lc", "<cmd>AutolistCheckbox<CR>", { desc = "Toggle checkbox" })
        
        -- List reordering
        vim.keymap.set("n", "<C-j>", "<cmd>AutolistMoveDown<CR>", { desc = "Move list item down" })
        vim.keymap.set("n", "<C-k>", "<cmd>AutolistMoveUp<CR>", { desc = "Move list item up" })
        
        -- List formatting
        vim.keymap.set("v", "<leader>lf", "<cmd>AutolistRecalculate<CR>", { desc = "Format list" })
      end

      -- Set up keymaps after autolist is loaded
      vim.defer_fn(setup_autolist_keymaps, 100)

      -- Custom commands for feminine bullets
      vim.api.nvim_create_user_command("FancyList", function()
        local fancy_bullets = {
          "🌸", "💕", "✨", "💖", "🌺", "🌷", "💗", "🦄", "🌈", "🎀"
        }
        local line = vim.api.nvim_get_current_line()
        local bullet = fancy_bullets[math.random(#fancy_bullets)]
        
        -- Replace existing bullet or add new one
        local new_line = line:gsub("^[%s%*%-%+%•%‣%⁃%∗%·%d%.%a%.%i%.%I%.]+", bullet .. " ")
        if new_line == line then
          new_line = bullet .. " " .. line
        end
        
        vim.api.nvim_set_current_line(new_line)
      end, { desc = "Add fancy bullet point" })

      -- Auto-apply fancy bullets in markdown files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set("n", "<leader>lb", "<cmd>FancyList<CR>", { buffer = true, desc = "Fancy bullet" })
        end,
      })
    end,
  },

  -- Which-key integration for autolist
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>l", group = "  List Management  " },
      },
    },
  },
}
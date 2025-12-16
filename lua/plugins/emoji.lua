-- Feminine emoji picker with cute categories
return {
  "hrsh7th/nvim-cmp",
  optional = true,
  opts = function(_, opts)
    -- Add emoji completion source if available
    if pcall(require, "cmp_emoji") then
      table.insert(opts.sources, { name = "emoji" })
    end
  end,
  
  -- Telescope emoji picker
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      
      -- Custom emoji picker with feminine styling
      opts.pickers = opts.pickers or {}
      opts.pickers.emoji = {
        prompt_title = "  ✨ Cute Emojis ✨ ",
        results_title = "Emojis",
        layout_strategy = "vertical",
        layout_config = {
          width = 0.8,
          height = 0.8,
          prompt_position = "top",
        },
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection then
              vim.api.nvim_put({ selection.value[1] }, "", false, true)
            end
          end)
          return true
        end,
      }
      
      -- Add feminine styling to telescope
      opts.defaults = opts.defaults or {}
      opts.defaults.borderchars = {
        prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      }
    end,
  },
  
  -- Simple emoji insertion
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>e", group = "Emoji" },
        { "<leader>ee", "<cmd>Telescope emoji<cr>", desc = "Emoji Picker" },
        { "<leader>es", "<cmd>Telescope symbols<cr>", desc = "Symbols" },
        { "<leader>eh", "<cmd>echo 'Use :emoji for emoji list'<cr>", desc = "Emoji Help" },
      },
    },
  },
  
  -- Custom emoji commands
  {
    "nvim-lua/plenary.nvim",
    config = function()
      -- Create custom emoji command
      vim.api.nvim_create_user_command("Emoji", function()
        local emojis = {
          "😊", "😍", "🥰", "😘", "💕", "❤️", "💖", "💗", "💓", "💞",
          "🌸", "🌺", "🌷", "🌹", "🏵️", "🌻", "🌼", "🌙", "⭐", "✨",
          "💄", "💅", "👑", "💎", "🎀", "🌈", "🦄", "🐰", "🐱", "🐶",
          "🍓", "🍒", "🍑", "🌺", "🍩", "🍰", "🍪", "🍫", "🍬", "🍭",
          "☕", "🥤", "🍵", "🌸", "🎀", "💝", "💌", "📝", "📚", "🎨"
        }
        
        -- Create a simple floating window with emojis
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, emojis)
        vim.api.nvim_buf_set_option(buf, "modifiable", false)
        
        local win = vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = 40,
          height = math.ceil(#emojis / 4),
          border = "rounded",
          style = "minimal",
          title = "  ✨ Quick Emojis ✨  ",
          title_pos = "center",
        })
        
        vim.api.nvim_win_set_option(win, "cursorline", true)
        
        -- Close on any key
        vim.keymap.set("n", "<CR>", function()
          local line = vim.api.nvim_win_get_cursor(win)[1]
          local emoji = emojis[line] or "😊"
          vim.api.nvim_win_close(win, true)
          vim.api.nvim_put({ emoji }, "", false, true)
        end, { buffer = buf })
        
        vim.keymap.set("n", "q", function()
          vim.api.nvim_win_close(win, true)
        end, { buffer = buf })
        
        vim.keymap.set("n", "<Esc>", function()
          vim.api.nvim_win_close(win, true)
        end, { buffer = buf })
      end, {})
    end,
  },
}
--  focus mode with distraction-free environment
return {
  -- Zen mode for ultimate focus
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop
        width = 120, -- width of the Zen window
        height = 0.85, -- height of the Zen window
        options = {
          signcolumn = "no", -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false, -- disable cursorline
          cursorcolumn = false, -- disable cursor column
          foldcolumn = "0", -- disable fold column
          list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler
          showcmd = false, -- disables the command in the last line
        },
        twilight = { enabled = true }, -- enable twilight plugin
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = false }, -- disables the tmux statusline
        -- this will change the font size when zen mode is on
        -- but it's not working for me so I disabled it
        alacritty = {
          enabled = false,
          font = "14", -- font size
        },
        -- this will change the font size when zen mode is on
        -- but it's not working for me so I disabled it
        kitty = {
          enabled = false,
          font = "+4", -- font size increment
        },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win)
        -- Add styling
        vim.api.nvim_win_set_option(win, "winhighlight", "Normal:Normal,FloatBorder:FloatBorder")
        vim.notify("  🌸 Focus mode activated  ", vim.log.levels.INFO, { title = "Zen Mode" })
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
        vim.notify("  💫 Welcome back!  ", vim.log.levels.INFO, { title = "Zen Mode" })
      end,
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "  Zen Mode  " },
    },
  },
  
  -- Twilight for dimming inactive parts of the file
  {
    "folke/twilight.nvim",
    opts = {
      dimming = {
        alpha = 0.25, -- amount of dimming
        color = { "Normal", "#ffffff" },
        term_bg = "#000000", -- if guibg=NONE, this will be used for the term
        inactive = false, -- when true, other windows will be fully dimmed
      },
      context = 10, -- amount of lines around the cursor to keep highlighted
      treesitter = true, -- use treesitter when available for the highlighting
      expand = {
        "function",
        "method",
        "table",
        "if_statement",
      },
      exclude = {}, -- exclude these filetypes
    },
  },
  
  -- Custom focus mode with aesthetics
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = "NoNeckPain",
    opts = {
      width = 120,
      buffers = {
        colors = {
          background = "#1a1a2e",
          text = "#ffffff",
          blend = 0.2,
        },
        bo = {
          filetype = "no-neck-pain",
          buftype = "nofile",
          bufhidden = "hide",
          buflisted = false,
        },
        scratchPad = {
          enabled = true,
          location = "~/Documents/no-neck-pain-left",
        },
      },
      autocmds = {
        enableOnVimEnter = false,
        enableOnTabEnter = false,
        reloadOnColorSchemeChange = false,
      },
      mappings = {
        enabled = true,
        toggle = "<Leader>z",
        widthUp = "<Leader>z-",
        widthDown = "<Leader>z+",
        scratchPad = "<Leader>zS",
      },
    },
  },
  
  -- Distraction-free writing
  {
    "pocco81/high-str.nvim",
    config = function()
      require("high-str").setup({
        verbosity = 0,
        highlighting = {
          -- Ex: highlight all occurrences of word 'test' in current buffer
          -- vim.cmd('Hi test')
          -- Ex: highlight all occurrences of word 'test' in all buffers
          -- vim.cmd('Hi! test')
          -- Ex: highlight all occurrences of pattern 'test' in current buffer
          -- vim.cmd('Hi! /test/')
          -- Ex: highlight all occurrences of pattern 'test' in all buffers
          -- vim.cmd('Hi!! /test/')
          -- Ex: remove all highlights in current buffer
          -- vim.cmd('Hi clear')
          -- Ex: remove all highlights in all buffers
          -- vim.cmd('Hi! clear')
        },
      })
    end,
  },
  
  -- Custom focus mode commands
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>f", group = "  Focus  " },
        { "<leader>fw", "<cmd>Twilight<cr>", desc = "  Twilight Focus  " },
        { "<leader>fn", "<cmd>NoNeckPain<cr>", desc = "  No Neck Pain  " },
        { "<leader>fz", "<cmd>ZenMode<cr>", desc = "  Zen Mode  " },
        { "<leader>fc", "<cmd>hi clear<cr>", desc = "  Clear Highlights  " },
      },
    },
  },
  
  -- Custom focus mode with ambient background
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      -- Add focus mode indicator to lualine
      table.insert(opts.sections.lualine_a, {
        function()
          if vim.g.zen_mode then
            return "  🌸 Zen  "
          elseif vim.g.twilight_enabled then
            return "  ✨ Focus  "
          elseif vim.g.no_neck_pain_enabled then
            return "  💫 Centered  "
          end
          return ""
        end,
        color = { fg = "#ff69b4", bg = "#1a1a2e" },
      })
    end,
  },
}
return {
  -- Buffer Delete
  {
    "famiu/bufdelete.nvim",
    config = function()
      -- No configuration needed, just load the plugin
    end,
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Set header
      dashboard.section.header.val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }

      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button("e", "  File Explorer", "<leader>e"),
        dashboard.button("f", "  Find File", "<leader>ff"),
        dashboard.button("r", "  Recent Files", "<leader>fr"),
        dashboard.button("t", "  Find Text", "<leader>fg"),
        dashboard.button("c", "  Configuration", "<leader>c"),
        dashboard.button("k", "  Keymaps", "<leader>kb"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      -- Set footer
      dashboard.section.footer.val = {
        [[Welcome to Neovim!]],
      }

      -- Configure layout
      dashboard.config.layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 2 },
        dashboard.section.footer,
      }

      -- Send config to alpha
      alpha.setup(dashboard.config)

      -- Keybindings
      vim.keymap.set("n", "<leader>ww", function()
        vim.cmd("only")  -- Close all other windows
        vim.cmd("Alpha")
      end, { desc = "Go to welcome screen" })

      -- Show dashboard on startup
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 then
            vim.schedule(function()
              vim.cmd("Alpha")
            end)
          end
        end,
      })

      -- Return to dashboard when last buffer is closed
      vim.api.nvim_create_autocmd("BufDelete", {
        callback = function()
          if #vim.fn.getbufinfo({ buflisted = 1 }) == 0 then
            vim.schedule(function()
              vim.cmd("only")  -- Close all other windows
              vim.cmd("Alpha")
            end)
          end
        end,
      })

      -- Ensure dashboard is shown when no files are opened
      if vim.fn.argc() == 0 then
        vim.schedule(function()
          vim.cmd("Alpha")
        end)
      end
    end,
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })

      -- Keybindings
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
      vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFindFile<cr>", { desc = "Find file in explorer" })
    end,
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "ordinal",
          close_command = function(bufnum)
            require("bufdelete").bufdelete(bufnum, true)
          end,
          right_mouse_command = function(bufnum)
            require("bufdelete").bufdelete(bufnum, true)
          end,
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator = {
            style = "icon",
            icon = "▎",
          },
          buffer_close_icon = "",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 18,
          max_prefix_length = 15,
          tab_size = 18,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            },
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          persist_buffer_sort = true,
          separator_style = "thin",
          enforce_regular_tabs = false,
          always_show_bufferline = true,
        },
      })

      -- Keybindings for buffer navigation and closing
      vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
      vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
      vim.keymap.set("n", "<S-q>", function()
        local bufnr = vim.api.nvim_get_current_buf()
        require("bufdelete").bufdelete(bufnr, true)
      end, { desc = "Close buffer" })
      vim.keymap.set("n", "<leader>ww", function()
        vim.cmd("only")  -- Close all other windows
        vim.cmd("Alpha")  -- Show dashboard
      end, { desc = "Go to welcome screen" })
    end,
  },

  -- Status Line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },

  -- Indent Blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "▏",
          tab_char = "▏",
        },
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
        },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
      })
    end,
  },
} 
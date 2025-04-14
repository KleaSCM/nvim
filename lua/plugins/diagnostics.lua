return {
  -- Diagnostics UI
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        position = "bottom",
        height = 10,
        width = 50,
        icons = true,
        mode = "workspace_diagnostics",
        severity = nil,
        fold_open = "",
        fold_closed = "",
        group = true,
        padding = true,
        cycle_results = true,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = { "<cr>", "<tab>", "<2-leftmouse>" },
          open_split = { "<c-x>" },
          open_vsplit = { "<c-v>" },
          open_tab = { "<c-t>" },
          jump_close = { "o" },
          toggle_mode = "m",
          switch_severity = "s",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          open_code_href = "c",
          close_folds = { "zM", "zm" },
          open_folds = { "zR", "zr" },
          toggle_fold = { "zA", "za" },
          previous = "k",
          next = "j",
          help = "?",
        },
        multiline = true,
        indent_lines = true,
        win_config = { border = "single" },
        auto_open = false,
        auto_close = false,
        auto_preview = true,
        auto_fold = false,
        auto_jump = { "lsp_definitions" },
        include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" },
        signs = {
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "﫠",
        },
        use_diagnostic_signs = true,
      })

      -- Keybindings
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics" })
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics" })
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List" })
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix List" })
      vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { desc = "LSP References" })
    end,
  },

  -- Notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        stages = "fade_in_slide_out",
        timeout = 3000,
        background_colour = "#000000",
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "✎",
        },
      })

      -- Override vim.notify to use nvim-notify
      vim.notify = require("notify")
    end,
  },

  -- Diagnostic Highlighting
  {
    "folke/lsp-colors.nvim",
    config = function()
      require("lsp-colors").setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981",
      })
    end,
  },
} 
return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Configure linters
      lint.linters_by_ft = {
        python = { "flake8", "mypy" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        lua = { "luacheck" },
        sh = { "shellcheck" },
        markdown = { "markdownlint" },
        yaml = { "yamllint" },
        json = { "jsonlint" },
        css = { "stylelint" },
        html = { "htmlhint" },
      }

      -- Configure linter options
      lint.linters.flake8.args = {
        "--max-line-length=88",
        "--extend-ignore=E203",
        "--format=%(row)d,%(col)d,%(code)s,%(text)s",
      }

      lint.linters.mypy.args = {
        "--ignore-missing-imports",
        "--follow-imports=silent",
        "--show-column-numbers",
      }

      -- Automatically lint on certain events
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      -- Keybindings
      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
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
        fold_open = "",
        fold_closed = "",
        group = true,
        padding = true,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = { "<cr>", "<tab>" },
          open_split = { "<c-x>" },
          open_vsplit = { "<c-v>" },
          open_tab = { "<c-t>" },
          jump_close = { "o" },
          toggle_mode = "m",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          close_folds = { "zM", "zm" },
          open_folds = { "zR", "zr" },
          toggle_fold = { "zA", "za" },
          previous = "k",
          next = "j",
        },
        indent_lines = true,
        auto_open = false,
        auto_close = false,
        auto_preview = true,
        auto_fold = false,
        auto_jump = { "lsp_definitions" },
        signs = {
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "﫠",
        },
        use_diagnostic_signs = false,
      })

      -- Keybindings
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics" })
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics" })
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List" })
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix List" })
    end,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("nvim-navic").setup({
        icons = {
          File = " ",
          Module = " ",
          Namespace = " ",
          Package = " ",
          Class = " ",
          Method = " ",
          Property = " ",
          Field = " ",
          Constructor = " ",
          Enum = "練",
          Interface = "練",
          Function = " ",
          Variable = " ",
          Constant = " ",
          String = " ",
          Number = " ",
          Boolean = "◩ ",
          Array = " ",
          Object = " ",
          Key = " ",
          Null = "ﳠ ",
          EnumMember = " ",
          Struct = " ",
          Event = " ",
          Operator = " ",
          TypeParameter = " ",
        },
        highlight = true,
        separator = "  ",
        depth_limit = 0,
        depth_limit_indicator = "..",
        safe_output = true,
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        yadm = {
          enable = false,
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        char = "▏",
        show_trailing_blankline_indent = false,
        show_first_indent_level = true,
        use_treesitter = true,
        show_current_context = true,
        show_current_context_start = true,
        context_patterns = {
          "class",
          "return",
          "function",
          "method",
          "^if",
          "^while",
          "jsx_element",
          "^for",
          "^object",
          "^table",
          "block",
          "arguments",
          "if_statement",
          "else_clause",
          "jsx_element",
          "jsx_self_closing_element",
          "try_statement",
          "catch_clause",
          "import_statement",
          "operation_type",
        },
        space_char_blankline = " ",
        show_end_of_line = true,
        filetype_exclude = {
          "help",
          "packer",
          "NvimTree",
          "Trouble",
          "TelescopePrompt",
          "TelescopeResults",
          "startify",
          "dashboard",
          "lazy",
          "neogitstatus",
          "Outline",
          "spectre_panel",
          "toggleterm",
          "qf",
        },
        buftype_exclude = {
          "terminal",
          "nofile",
        },
      })
    end,
  },
} 
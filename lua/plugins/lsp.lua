return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      { "williamboman/mason-lspconfig.nvim" },

      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      -- Setup language servers
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      local servers = { "clangd", "rust_analyzer", "pyright", "ts_ls", "lua_ls" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          capabilities = capabilities,
        }
      end

      -- Configure LSP diagnostics
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 4,
          severity = {
            min = vim.diagnostic.severity.HINT,
          },
          source = "if_many",
          format = function(diagnostic)
            local icons = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.INFO] = " ",
              [vim.diagnostic.severity.HINT] = " ",
            }
            local icon = icons[diagnostic.severity] or "● "
            return icon .. (diagnostic.message or "")
          end,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
        underline = {
          severity = {
            min = vim.diagnostic.severity.HINT,
          },
        },
        float = {
          border = "single",
          source = "if_many",
          header = "",
          prefix = function(diagnostic)
            local icons = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.INFO] = " ",
              [vim.diagnostic.severity.HINT] = " ",
            }
            return icons[diagnostic.severity] or "● "
          end,
        },
        severity_sort = true,
      })

      -- Set up LSP keymaps
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

      -- Highlight diagnostics
      vim.cmd([[
        highlight DiagnosticError guifg=#db4b4b gui=bold,underline
        highlight DiagnosticWarn guifg=#e0af68 gui=bold,underline
        highlight DiagnosticInfo guifg=#0db9d7 gui=bold,underline
        highlight DiagnosticHint guifg=#10B981 gui=bold,underline
        highlight DiagnosticVirtualTextError guibg=#db4b4b guifg=#ffffff gui=bold
        highlight DiagnosticVirtualTextWarn guibg=#e0af68 guifg=#ffffff gui=bold
        highlight DiagnosticVirtualTextInfo guibg=#0db9d7 guifg=#ffffff gui=bold
        highlight DiagnosticVirtualTextHint guibg=#10B981 guifg=#ffffff gui=bold
      ]])

      -- Auto-format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          vim.lsp.buf.format()
        end,
      })

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end,
  },
} 
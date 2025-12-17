return {
  {
    "nvimtools/none-ls.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local ok, null_ls = pcall(require, "none-ls")
      if not ok then
        ok, null_ls = pcall(require, "null-ls")
      end
      if not ok then
        vim.notify("null-ls/none-ls not available", vim.log.levels.WARN)
        return
      end

      local builtins = null_ls.builtins or null_ls.register or null_ls.builtins
      null_ls.setup({
        sources = {
          -- common formatters/linters; installed system-wide or via mason
          (builtins.formatting and builtins.formatting.prettier and builtins.formatting.prettier.with and builtins.formatting.prettier.with({ extra_args = { "--no-semi" } })) or nil,
          (builtins.formatting and builtins.formatting.black) or nil,
          (builtins.diagnostics and builtins.diagnostics.eslint) or nil,
          (builtins.diagnostics and builtins.diagnostics.ruff) or nil,
        },
        on_attach = function(client, bufnr)
          -- prefer null-ls for formatting if available
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", { noremap=true, silent=true })
          end
        end,
      })
    end,
  },
}

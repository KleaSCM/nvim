return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local ok, tsconfigs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        vim.notify("nvim-treesitter not available", vim.log.levels.WARN)
        return
      end
      tsconfigs.setup({
        ensure_installed = { "lua", "python", "javascript", "markdown", "bash" },
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
        auto_install = true,
      })
    end,
  },
}

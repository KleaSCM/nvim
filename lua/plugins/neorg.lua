return {
  {
    "nvim-neorg/neorg",
    cmd = "Neorg",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- build removed: use `:Neorg sync-parsers` manually after install if needed
    opts = function()
      local ok, neorg = pcall(require, "neorg")
      if not ok then
        return {}
      end
      neorg.setup({
        load = {
          ["core.defaults"] = {},
          ["core.norg.concealer"] = {},
          ["core.norg.dirman"] = {
            config = {
              workspaces = {
                notes = vim.fn.expand("~/neorg")
              },
            },
          },
        },
      })
      return {}
    end,
  },
}

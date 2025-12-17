return {
  {
    "renerocksai/telekasten.nvim",
    cmd = "Telekasten",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    opts = function()
      local home = vim.fn.expand("~/notes")
      local ok, telekasten = pcall(require, "telekasten")
      if not ok then
        return {}
      end
      telekasten.setup({
        home = home,
        take_over_my_home = false,
      })
      return {}
    end,
  },
}

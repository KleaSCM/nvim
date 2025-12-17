return {
  {
    "rebelot/heirline.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lualine/lualine.nvim" },
    config = function()
      local ok, heirline = pcall(require, "heirline")
      if not ok then
        vim.notify("heirline not available", vim.log.levels.WARN)
        return
      end
      -- Minimal heirline setup: use statusline from lualine as fallback
      pcall(function()
        heirline.setup()
      end)
    end,
  },
}

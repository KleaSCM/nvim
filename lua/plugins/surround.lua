-- Surround text objects with feminine styling
return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
        surrounds = {
          -- Feminine quote pairs
          ["f"] = {
            add = { "「", "」" },
            find = "「.-」",
            delete = "^(「)().-(」)$",
          },
          ["c"] = {
            add = { "『", "』" },
            find = "『.-』",
            delete = "^(『)().-(』)$",
          },
          -- Heart brackets
          ["h"] = {
            add = { "❤", "❤" },
            find = "❤.-❤",
            delete = "^(❤)().-(❤)$",
          },
          -- Star brackets
          ["s"] = {
            add = { "✨", "✨" },
            find = "✨.-✨",
            delete = "^(✨)().-(✨)$",
          },
          -- Flower brackets
          ["p"] = {
            add = { "🌸", "🌸" },
            find = "🌸.-🌸",
            delete = "^(🌸)().-(🌸)$",
          },
        },
        highlight = {
          duration = 0,
        },
      })
    end,
  },

  -- Which-key integration for surround
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "ys", group = "  Surround  " },
        { "ds", group = "  Delete Surround  " },
        { "cs", group = "  Change Surround  " },
      },
    },
  },
}
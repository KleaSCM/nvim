return {
  "3rd/image.nvim",
  dependencies = { "luarocks.nvim" },
  config = function()
    require("image").setup({
      backend = "kitty", -- or "ueberzug" or "wezterm"
      integrations = {
        markdown = {
          enabled = true,
          download_remote_images = true,
          clear_in_insert_mode = false,
          render_on_cursor_hold = true,
        },
        neorg = {
          enabled = true,
          download_remote_images = true,
          clear_in_insert_mode = false,
          render_on_cursor_hold = true,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
    })
  end,
} 
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
          file_previewer = {
            -- Exclude binary files from preview
            previewer = function(opts)
              local previewers = require("telescope.previewers")
              local previewer = previewers.new_buffer_previewer({
                title = "File Preview",
                get_buffer_by_name = function(_, entry)
                  return entry.value
                end,
                define_preview = function(self, entry, status)
                  local p = vim.loop.fs_stat(entry.value)
                  if p and p.type == "file" then
                    local filetype = vim.filetype.match({ filename = entry.value })
                    if filetype == "binary" then
                      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
                        "Binary file preview not available",
                        "File: " .. entry.value,
                      })
                      return
                    end
                  end
                  return previewers.buffer_previewer_maker(entry.value, self.state.bufnr, {
                    bufname = self.state.bufname,
                  })
                end,
              })
              return previewer
            end,
          },
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
      })

      -- Keybindings
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    end,
  },
} 
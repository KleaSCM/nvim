-- git integration with styled blame and emoji commits
return {
  -- Enhanced git signs with colors
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "│", hl = "GitSignsAdd" },
        change = { text = "│", hl = "GitSignsChange" },
        delete = { text = "_", hl = "GitSignsDelete" },
        topdelete = { text = "‾", hl = "GitSignsDelete" },
        changedelete = { text = "~", hl = "GitSignsChange" },
        untracked = { text = "│", hl = "GitSignsAdd" },
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
      current_line_blame_formatter = "  <author>, <author_time> - <summary>  ",
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
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
      
      --highlight groups
      vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#98c379", bg = nil })
      vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#61afef", bg = nil })
      vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#e06c75", bg = nil })
      vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#ff69b4", bg = nil, italic = true })
    end,
  },
  
  -- Git blame with styling
  {
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup({
        blame_options = { "-w" },
        merge_consecutive = true,
        max_summary_length = 20,
        blame_format = "  <author> • <time> • <summary>  ",
        date_format = "%Y-%m-%d",
        virtual_style = "float",
        highlight_group = "FloatBorder",
        border_style = "single",
        title = "  🌸 Git Blame 🌸  ",
        title_pos = "center",
      })
    end,
    keys = {
      { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "  Git Blame  " },
      { "<leader>gB", "<cmd>BlameOpen<cr>", desc = "  Git Blame File  " },
    },
  },
  
  -- Enhanced git commit with emoji support
  {
    "rhysd/committia.vim",
    config = function()
      vim.g.committia_open_window_vsplit = 1
      vim.g.committia_use_singlecolumn = "always"
      vim.g.committia_edit_window_width = 80
      vim.g.committia_status_window_winwidth = 1
      vim.g.committia_status_window_winheight = 1
    end,
  },
  
  -- Git commit message templates with emojis
  {
    "aaronhallaert/advanced-git-search.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-fugitive",
      "tpope/vim-rhubarb",
    },
    config = function()
      require("telescope").load_extension("advanced_git_search")
    end,
    keys = {
      { "<leader>gs", "<cmd>Telescope advanced_git_search<cr>", desc = "  Git Search  " },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "  Git Commits  " },
      { "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "  Buffer Commits  " },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "  Git Branches  " },
    },
  },
  
  -- Custom git commit helper with emojis
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      
      -- Git commit emoji picker
      opts.pickers = opts.pickers or {}
      opts.pickers.git_commit_emoji = {
        prompt_title = "  ✨ Commit Type ✨ ",
        finder = require("telescope.finders").new_table({
          results = {
            { emoji = "✨", type = "feat", description = "A new feature" },
            { emoji = "🐛", type = "fix", description = "A bug fix" },
            { emoji = "📚", type = "docs", description = "Documentation only changes" },
            { emoji = "💄", type = "style", description = "Changes that do not affect the meaning of the code" },
            { emoji = "♻️", type = "refactor", description = "A code change that neither fixes a bug nor adds a feature" },
            { emoji = "⚡", type = "perf", description = "A code change that improves performance" },
            { emoji = "✅", type = "test", description = "Adding missing tests or correcting existing tests" },
            { emoji = "🔧", type = "chore", description = "Changes to the build process or auxiliary tools" },
            { emoji = "🌸", type = "custom", description = "Custom feminine touch" },
          },
          entry_maker = function(entry)
            return {
              value = entry,
              display = string.format("%s %s - %s", entry.emoji, entry.type, entry.description),
              ordinal = entry.type .. " " .. entry.description,
            }
          end,
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection then
              local commit_type = selection.value.type
              local commit_emoji = selection.value.emoji
              local commit_msg = vim.fn.input("Commit message: ")
              if commit_msg ~= "" then
                vim.cmd(string.format('!git commit -m "%s %s: %s"', commit_emoji, commit_type, commit_msg))
              end
            end
          end)
          return true
        end,
      }
      
      -- Add git commit emoji command
      vim.api.nvim_create_user_command("GitCommitEmoji", function()
        require("telescope").extensions.git_commit_emoji.git_commit_emoji()
      end, {})
    end,
  },
  
  -- Git status with styling
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        keymaps = {
          view = {
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "  Close Diffview  " } },
            { "n", "<leader>co", "<cmd>Git checkout<cr>", { desc = "  Checkout  " } },
          },
          file_panel = {
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "  Close Diffview  " } },
          },
        },
      })
    end,
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "  Git Diff  " },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "  File History  " },
    },
  },
  
  -- Which-key integration for git
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>g", group = "  Git  " },
      },
    },
  },
}
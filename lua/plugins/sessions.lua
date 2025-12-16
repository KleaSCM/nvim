-- Smart session management with feminine styling
return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
      options = { "buffers", "curdir", "tabpages", "winsize" },
      pre_save = nil,
      save_empty = false,
    },
    config = function(_, opts)
      require("persistence").setup(opts)
      
      -- Auto-save session on specific events
      local function auto_save_session()
        local session_name = vim.fn.getcwd():gsub("/", "%%")
        require("persistence").save({ session = session_name })
        vim.notify("  ✨ Session saved!  ", vim.log.levels.INFO, { title = "Session Manager" })
      end
      
      -- Auto-save on VimLeave
      vim.api.nvim_create_autocmd("VimLeave", {
        callback = auto_save_session,
        desc = "Auto-save session on exit",
      })
      
      -- Auto-save every 5 minutes
      local timer = vim.loop.new_timer()
      timer:start(300000, 300000, vim.schedule_wrap(auto_save_session))
      
      -- Don't auto-restore session on startup - let user choose
      -- vim.api.nvim_create_autocmd("VimEnter", {
      --   callback = function()
      --     if vim.fn.argc() == 0 then
      --       require("persistence").load()
      --     end
      --   end,
      --   nested = true,
      -- })
    end,
  },
  
  -- Session management UI
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      log_level = "error",
      auto_session_enable_last_session = true,
      auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = false,
      auto_session_enable_last_session = false,
      auto_session_suppress_dirs = nil,
      auto_session_use_git_branch = false,
      -- Session controls
      session_lens = {
        buftypes_to_ignore = nil,
        load_on_setup = true,
        theme_conf = {
          border = true,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
        previewer = false,
      },
    },
    config = function(_, opts)
      require("auto-session").setup(opts)
      
      -- Feminine styling for session lens
      local telescope = require("telescope")
      local themes = require("telescope.themes")
      
      vim.api.nvim_create_user_command("SessionSearch", function()
        require("auto-session.session-lens").search_session(themes.get_dropdown({
          winblend = 10,
          border = true,
          previewer = false,
          prompt_title = "  ✨ Sessions ✨ ",
          results_title = "Your Sessions",
          layout_strategy = "vertical",
          layout_config = {
            width = 0.6,
            height = 0.7,
          },
        }))
      end, {})
      
      -- Keymaps for session management
      vim.keymap.set("n", "<leader>sl", "<cmd>SessionSearch<CR>", { desc = "  Sessions  " })
      vim.keymap.set("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "  Save Session  " })
      vim.keymap.set("n", "<leader>sr", "<cmd>SessionRestore<CR>", { desc = "  Restore Session  " })
      vim.keymap.set("n", "<leader>sd", "<cmd>SessionDelete<CR>", { desc = "  Delete Session  " })
    end,
  },
  
  -- Project-specific session management
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        manual_mode = false,
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = "global",
        datapath = vim.fn.stdpath("data"),
      })
      
      -- Load telescope extension
      require("telescope").load_extension("projects")
      
      -- Project session integration
      local function save_project_session()
        local project_root = require("project_nvim.project").get_project_root()
        if project_root then
          local session_name = project_root:gsub("/", "%%")
          require("persistence").save({ session = session_name })
          vim.notify("  ✨ Project session saved!  ", vim.log.levels.INFO, { title = "Project Session" })
        end
      end
      
      local function restore_project_session()
        local project_root = require("project_nvim.project").get_project_root()
        if project_root then
          local session_name = project_root:gsub("/", "%%")
          require("persistence").load({ session = session_name })
        end
      end
      
      -- Auto-save project session
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
          vim.defer_fn(save_project_session, 1000)
        end,
        desc = "Auto-save project session on directory change",
      })
      
      -- Keymaps for project sessions
      vim.keymap.set("n", "<leader>ps", save_project_session, { desc = "  Save Project Session  " })
      vim.keymap.set("n", "<leader>pr", restore_project_session, { desc = "  Restore Project Session  " })
    end,
  },
  
  -- Which-key integration
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>s", group = "  Session  " },
        { "<leader>p", group = "  Project  " },
      },
    },
  },
}
-- Config for ~/.config/nvim/lua/plugins/dashboard-custom.lua

-- ASCII art header
local custom_header = {
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠤⠔⠀⠁⠲⠤⣤⡀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠒⠁⠀⢁⠂⠄⡠⠀⠠⢁⠡⠀⢍⠢⣀⠀⠜⢢⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠸⢦⠄⠀⣠⠊⠁⠀⣰⠄⡀⠙⠋⠳⠀⠁⠀⠠⣀⠠⢈⠊⠳⡄⡺⠖⠊⢹⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡄⠀⠙⡶⠁⡴⠂⡰⠃⢈⡆⠀⠇⠂⢸⠀⠀⠡⡈⢧⠀⠘⠒⠚⡥⠀⠀⣸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⣠⠔⠓⠳⣀⡼⢁⡜⠀⡰⠁⠀⣼⠀⢈⠀⠄⠈⡇⠀⠀⢱⠘⣷⠀⠈⡼⢻⡀⠰⠿⣟⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠗⡄⠀⣸⠁⣼⡠⢲⠃⠀⢠⡇⠈⢀⠂⠀⠈⣇⢰⠀⠈⢆⠐⢣⢰⠁⣸⡷⣄⣀⣈⠾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⣰⢀⠟⠁⣇⠸⠇⡀⢏⡇⢰⡏⡇⠀⠀⠀⡀⢠⠟⣌⣄⠀⢸⠆⠌⡇⣇⢸⣿⠈⢿⠤⠇⢇⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⡟⡧⣤⢖⡇⢸⠀⠰⣸⠠⡞⠒⢳⢈⠓⠙⠠⡸⠀⠹⡿⡌⠉⡇⢂⠹⢸⣹⡿⣿⠾⣹⢰⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⢀⣧⡶⠇⠈⣷⢸⠀⢱⢋⣞⣀⡀⠈⢫⡀⠀⢣⡀⠀⣠⣿⣷⣦⣆⢸⣻⣎⢹⡇⠙⢽⣔⠂⠘⠆⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⡺⠁⠀⣼⠷⣿⡴⠈⢰⣿⢿⣿⣿⣧⠀⠱⠀⠀⠀⠀⣿⣿⣿⠏⢻⣾⠿⢷⣾⢁⣀⣀⠉⡿⣘⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⢀⠔⠀⠀⡘⠋⠀⢺⡇⠹⣾⣏⠀⢿⠛⠿⠀⠀⠀⠀⠀⠀⠑⠠⠚⠀⣼⠃⠀⢨⢻⣸⣉⣻⠀⠃⢈⣦⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠐⢏⢠⢴⢹⠳⣤⣠⣾⢷⠀⠸⣿⡄⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠠⢋⣤⡴⡏⣟⣈⡜⠁⠐⠾⠛⡬⠂⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠈⢹⢸⠀⣿⣽⣟⢺⡄⡂⣿⡟⣄⠀⠀⠀⠀⠀⠀⠀⠀⢀⠔⣿⠋⡷⢀⡟⠤⡟⣄⣠⠞⣦⡰⡄⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⢠⠿⠀⢸⡟⣼⠂⢸⣇⢡⠸⡿⠇⠁⠠⢀⡀⠀⠀⠀⣀⠤⡶⠁⢈⣿⠟⢅⢸⠃⣶⠭⣈⣷⠈⣇⠈⠃⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⡀⢰⢮⠀⣿⠙⣾⠀⡞⣼⢌⢷⡱⢄⡀⠀⠠⠘⡌⠉⠁⢀⠔⣓⣀⠜⠃⠀⢀⡝⢠⡏⣷⡂⢼⣶⡘⢄⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⢁⡿⠉⣼⠃⣸⢏⡼⠁⣿⡆⠙⠊⠳⠤⠄⠀⡰⢣⡤⣂⡥⠒⠙⡄⠀⠀⠀⡾⠸⣼⡇⢡⢻⡐⣯⣹⡪⢦⡀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⡜⠀⢸⠃⠈⡎⢋⡄⣼⣧⢹⠀⠀⠀⢀⠠⠊⠀⠀⢠⠿⡄⠀⠀⠈⠐⠄⣀⢧⠸⣟⣧⠀⢧⢱⠘⢧⣟⢄⠳⡄⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⣸⡇⢰⠇⠀⡈⠀⡿⠀⣾⡷⠾⠰⠶⡎⢀⠀⠀⠀⣀⣿⣀⣾⠀⠀⠈⠀⠀⣀⡹⠏⠉⠉⢇⠀⠹⣷⠀⠷⡀⢇⢸⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⢰⣇⠗⠁⠀⠀⠀⣼⣧⡾⡡⠀⠀⠀⠑⢌⠒⢴⣲⠀⢠⣾⠛⣻⣄⡀⢠⡔⠝⠁⠀⠀⠀⠀⠀⢡⠀⠙⠷⣀⠑⢤⣛⡇⠀⠀⠀⠀",
  "",
}

return {
  {
    "nvimdev/dashboard-nvim",
    lazy = false, -- dashboard-nvim shouldn't be lazy-loaded to properly handle stdin
    opts = function()
      -- Default LazyVim dashboard config with custom header
      local opts = {
        theme = "doom",
        hide = {
          statusline = false, -- this is taken care of by lualine
        },
        config = {
          header = custom_header, -- use the direct ASCII art
          -- stylua: ignore
          center = {
            {action = 'lua LazyVim.pick()()', desc = " Find File", key = "f"},
            {action = "ene | startinsert", desc = " New File", key = "n"},
            {action = 'lua LazyVim.pick("projects")()', desc = " Projects", key = "p"},
            {action = 'lua LazyVim.pick("live_grep")()', desc = " Find Text", key = "g"},
            {action = 'lua LazyVim.pick("oldfiles")()', desc = " Recent Files", key = "r"},
            {action = 'lua LazyVim.pick.config_files()()', desc = " Config", key = "c"},
            {action = 'lua require("persistence").load()', desc = " Restore Session", key = "s"},
            {action = "LazyExtras", desc = " Lazy Extras", key = "x"},
            {action = "Lazy", desc = " Lazy", key = "l"},
            {action = function() vim.api.nvim_input("qa") end, desc = " Quit", key = "q"},
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return {"⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"}
          end,
        },
      }

      -- Format buttons
      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = " %s"
      end

      -- open dashboard after closing lazy
      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
            end)
          end,
        })
      end

      return opts
    end,
    keys = {
      { "<leader>dd", "<cmd>Dashboard<cr>", desc = "  Dashboard  " },
      { "<leader>dh", "<cmd>Dashboard<cr>", desc = "  Home Dashboard  " },
    },
  },

  -- Ensure dashboard shows on startup
  {
    "nvimdev/dashboard-nvim",
    config = function()
      -- Show dashboard on startup if no files specified
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 then
            vim.defer_fn(function()
              require("dashboard").instance()
            end, 100)
          end
        end,
        once = true,
      })
    end,
  },

  -- Which-key integration for dashboard
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>d", group = "  Dashboard  " },
      },
    },
  },
}
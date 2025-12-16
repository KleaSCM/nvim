-- hover effects and smooth transitions
return {
  -- Smooth cursor animations
  {
    "gen740/SmoothCursor.nvim",
    config = function()
      require("smoothcursor").setup({
        type = "default", -- Cursor movement animation style
        cursor = "❤️", -- Cursor character
        texthl = "SmoothCursor", -- Highlight group. Default is { bg = nil, fg = "#FFD700" }
        linehl = nil, -- Highlights line under cursor, default nil
        unstopable = false, -- Uncurable cursor animation, set to true for infinite animation
        flyin_effect = nil, -- "bottom" or "top"
        speed = 25, -- Max speed of cursor
        intervals = 35, -- Update intervals in milliseconds
        timeout = 3000, -- Timeout for animations in milliseconds
        threshold = 3, -- Move cursor threshold
        disable_float_win = false, -- Disable in floating windows
        enabled_filetypes = nil, -- Enable only in specific filetypes
        disabled_filetypes = { "TelescopePrompt", "NvimTree" }, -- Disable in specific filetypes
      })
    end,
  },
  
  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        -- All these settings will be passed to the actual scrolling function
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = "quadratic", -- Default easing function
        pre_hook = nil,
        post_hook = nil,
        performance_mode = false,
      })
      
      -- Set custom easing functions for feminine feel
      local t = {}
      -- Quadratic easing: f(t) = t^2
      t.quadratic = function(s)
        return s * s
      end
      -- Cubic easing: f(t) = t^3
      t.cubic = function(s)
        return s * s * s
      end
      -- Exponential easing: f(t) = 2^(10*(t-1))
      t.exponential = function(s)
        return s == 0 and 0 or math.pow(2, 10 * s - 10)
      end
      -- Circular easing: f(t) = 1 - sqrt(1 - t^2)
      t.circular = function(s)
        return 1 - math.sqrt(1 - s * s)
      end
      
      -- Smooth scroll mappings with feminine easing
      local mappings = {
        ["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "350", "circular" } },
        ["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "350", "circular" } },
        ["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "450", "circular" } },
        ["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "450", "circular" } },
        ["<C-y>"] = { "scroll", { "-0.10", "false", "100", "circular" } },
        ["<C-e>"] = { "scroll", { "0.10", "false", "100", "circular" } },
        ["zt"] = { "zt", { "300" } },
        ["zz"] = { "zz", { "300" } },
        ["zb"] = { "zb", { "300" } },
      }
      
      for key, mapping in pairs(mappings) do
        vim.keymap.set({ "n", "x", "c" }, key, function()
          require("neoscroll").scroll(unpack(mapping))
        end, { desc = "Smooth scroll" })
      end
    end,
  },
  
  -- Highlight on yank with colors
  {
    "machakann/vim-highlightedyank",
    config = function()
      vim.g.highlightedyank_highlight_duration = 300
      vim.g.highlightedyank_highlight_color = {
        guibg = "#ff69b4", -- Hot pink
        ctermbg = "198",
      }
    end,
  },
  
  -- Smooth window focus transitions
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    version = "2.*",
    config = function()
      require("window-picker").setup({
        hint = "floating-big-letter",
        show_prompt = true,
        prompt_message = "  ✨ Pick a window ✨ ",
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal" },
          },
        },
        highlights = {
          statusline = {
            focused = {
              bg = "#ff69b4", -- Hot pink
              fg = "#ffffff",
              bold = true,
            },
            unfocused = {
              bg = "#4a4a4a",
              fg = "#ffffff",
            },
          },
          win_picker = {
            fg = "#ffffff",
            bg = "#ff1493", -- Deep pink
            bold = true,
          },
        },
      })
    end,
  },
  
  -- Animated statusline
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      -- Add colors and animations
      opts.options = opts.options or {}
      opts.options.theme = "auto"
      opts.options.section_separators = {
        left = "",
        right = "",
      }
      opts.options.component_separators = {
        left = "",
        right = "",
      }
      
      -- Add animated sections
      table.insert(opts.sections.lualine_x, {
        function()
          local hour = tonumber(os.date("%H"))
          local greeting = ""
          local icon = ""
          
          if hour < 6 then
            greeting = "Night owl"
            icon = ""
          elseif hour < 12 then
            greeting = "Good morning"
            icon = ""
          elseif hour < 18 then
            greeting = "Good afternoon"
            icon = ""
          else
            greeting = "Good evening"
            icon = ""
          end
          
          return string.format("%s %s", icon, greeting)
        end,
        padding = { left = 1, right = 1 },
      })
      
      return opts
    end,
  },
}
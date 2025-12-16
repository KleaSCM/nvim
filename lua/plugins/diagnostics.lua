return {
  -- Enhanced diagnostics configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        -- Make diagnostics extremely visible
        underline = true,
        update_in_insert = true, -- Show diagnostics even in insert mode
        virtual_text = {
          spacing = 2,
          source = "always", -- Always show the source
          prefix = "🔥", -- Use fire emoji for maximum visibility
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "🚨", -- Loud error icon
            [vim.diagnostic.severity.WARN] = "⚠️", -- Warning icon
            [vim.diagnostic.severity.HINT] = "💡", -- Hint icon
            [vim.diagnostic.severity.INFO] = "ℹ️", -- Info icon
          },
          -- Make signs larger and more prominent
          numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
          },
          linehl = { -- Highlight the entire line
            [vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
            [vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
          },
        },
        -- Show floating diagnostics on cursor hover
        float = {
          source = "always",
          border = "rounded",
          header = "",
          prefix = "",
        },
      },
    },
  },

  -- Configure vim.diagnostic to be more aggressive
  {
    "LazyVim/LazyVim",
    config = function()
      -- Enhanced diagnostic configuration
      vim.diagnostic.config({
        underline = {
          severity = { min = vim.diagnostic.severity.WARN }, -- Underline warnings and errors
        },
        virtual_text = {
          spacing = 1,
          source = "always",
          prefix = "🔥",
          format = function(diagnostic)
            -- Make diagnostic messages more prominent
            local message = diagnostic.message
            local source = diagnostic.source or "Unknown"
            local severity = vim.diagnostic.severity[diagnostic.severity]:lower()
            return string.format("[%s] %s: %s", severity:upper(), source, message)
          end,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "🚨",
            [vim.diagnostic.severity.WARN] = "⚠️",
            [vim.diagnostic.severity.HINT] = "💡",
            [vim.diagnostic.severity.INFO] = "ℹ️",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
          },
          linehl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
            [vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
          },
        },
        severity_sort = true,
        update_in_insert = true,
        float = {
          source = "always",
          border = "double", -- More prominent border
          header = "🔥 DIAGNOSTICS 🔥",
          prefix = "",
          format = function(diagnostic)
            local message = diagnostic.message
            local source = diagnostic.source or "Unknown"
            local code = diagnostic.code or ""
            local severity = vim.diagnostic.severity[diagnostic.severity]:upper()
            local formatted = string.format("🔥 %s 🔥\nSource: %s", severity, source)
            if code ~= "" then
              formatted = formatted .. string.format("\nCode: %s", code)
            end
            formatted = formatted .. string.format("\n\n%s", message)
            return formatted
          end,
        },
      })

      -- Set up autocmds to make diagnostics even more visible
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          -- Always show diagnostics on cursor hold
          vim.diagnostic.open_float(nil, {
            focus = false,
            close_events = { "CursorMoved", "BufLeave", "InsertEnter", "FocusLost" },
            border = "double",
            header = "🔥 DIAGNOSTICS 🔥",
            prefix = " ",
            scope = "cursor",
          })
        end,
      })

      -- Make diagnostic signs flash for errors
      vim.api.nvim_create_autocmd("DiagnosticChanged", {
        callback = function(args)
          local bufnr = args.buf
          local diagnostics = vim.diagnostic.get(bufnr)
          for _, diagnostic in ipairs(diagnostics) do
            if diagnostic.severity == vim.diagnostic.severity.ERROR then
              -- Flash the sign column for errors
              vim.defer_fn(function()
                vim.api.nvim_set_hl(0, "DiagnosticSignError", { 
                  fg = "#ff0000", 
                  bg = "#ffff00", 
                  bold = true, 
                  standout = true,
                  reverse = true,
                })
              end, 100)
              vim.defer_fn(function()
                vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#ff0000", bold = true })
              end, 500)
            end
          end
        end,
      })
    end,
  },

  -- Configure trouble.nvim to be more prominent
  {
    "folke/trouble.nvim",
    opts = {
      -- Make trouble window more prominent
      use_diagnostic_signs = true,
      action_keys = {
        -- Key mappings for trouble window
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = { "<cr>", "<tab>" },
        toggle_mode = "m",
        preview = "p",
        hover = "K",
      },
      icons = {
        -- Make icons more prominent
        error = "🚨",
        warning = "⚠️",
        hint = "💡",
        information = "ℹ️",
        other = "📝",
      },
      fold_open = "▼",
      fold_closed = "▶",
      indent_lines = false,
      modes = {
        diagnostics = { auto_open = true }, -- Auto open trouble when diagnostics appear
      },
      auto_close = false, -- Don't auto close
      auto_preview = true,
      signs = {
        error = "🚨",
        warning = "⚠️",
        hint = "💡",
        information = "ℹ️",
        other = "📝",
      },
    },
  },

  -- Custom diagnostic highlight groups
  {
    "LazyVim/LazyVim",
    config = function()
      -- Define custom highlight groups for more prominent diagnostics
      vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff0000", bg = "#330000", bold = true, standout = true })
      vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#ffa500", bg = "#332200", bold = true, standout = true })
      vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#00ffff", bg = "#003333", bold = true, standout = true })
      vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#ffff00", bg = "#333300", bold = true, standout = true })
      
      -- Make underlines more prominent
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = "#ff0000", undercurl = true, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = "#ffa500", undercurl = true, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = "#00ffff", undercurl = true, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = "#ffff00", undercurl = true, bold = true })
      
      -- Make virtual text more prominent
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff0000", bg = "#330000", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ffa500", bg = "#332200", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#00ffff", bg = "#003333", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#ffff00", bg = "#333300", bold = true })
    end,
  },

  -- Force enable inline diagnostics at the end
  {
    "LazyVim/LazyVim",
    config = function()
      -- Ensure virtual text is always enabled
      vim.diagnostic.config({
        virtual_text = true,
        update_in_insert = true,
      })
    end,
  },
}
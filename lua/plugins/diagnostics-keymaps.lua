-- Enhanced diagnostics keymaps and visual feedback
return {
  "folke/lazy.nvim",
  opts = {
    -- This is a configuration-only plugin that sets up diagnostics keymaps
  },
  config = function()
    -- Enhanced diagnostic keymaps
    vim.keymap.set("n", "<leader>dd", function()
      vim.diagnostic.open_float(nil, {
        focus = false,
        border = "double",
        header = "🔥 ALL DIAGNOSTICS 🔥",
        scope = "line",
      })
    end, { desc = "Show Line Diagnostics (Loud)" })

    vim.keymap.set("n", "<leader>dD", function()
      vim.diagnostic.open_float(nil, {
        focus = false,
        border = "double",
        header = "🔥 ALL DIAGNOSTICS 🔥",
        scope = "cursor",
      })
    end, { desc = "Show Cursor Diagnostics (Loud)" })

    -- Toggle diagnostic loudness
    local loud_mode = true
    vim.keymap.set("n", "<leader>dl", function()
      loud_mode = not loud_mode
      if loud_mode then
        vim.diagnostic.config({
          virtual_text = {
            spacing = 1,
            source = "always",
            prefix = "🔥",
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
          float = {
            border = "double",
            header = "🔥 DIAGNOSTICS 🔥",
          },
        })
        vim.notify("🔥 LOUD DIAGNOSTICS MODE ENABLED 🔥", vim.log.levels.INFO)
      else
        vim.diagnostic.config({
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
          },
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = "",
              [vim.diagnostic.severity.WARN] = "",
              [vim.diagnostic.severity.HINT] = "",
              [vim.diagnostic.severity.INFO] = "",
            },
            numhl = {},
            linehl = {},
          },
          float = {
            border = "rounded",
            header = "",
          },
        })
        vim.notify("🔇 Quiet diagnostics mode", vim.log.levels.INFO)
      end
    end, { desc = "Toggle Loud Diagnostics" })

    -- Make diagnostic errors flash continuously
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
      callback = function(args)
        local bufnr = args.buf
        local diagnostics = vim.diagnostic.get(bufnr)
        for _, diagnostic in ipairs(diagnostics) do
          if diagnostic.severity == vim.diagnostic.severity.ERROR then
            -- Create continuous flashing for errors
            local flash_count = 0
            local function flash()
              if flash_count < 6 then -- Flash 3 times
                flash_count = flash_count + 1
                if flash_count % 2 == 1 then
                  vim.api.nvim_set_hl(0, "DiagnosticSignError", { 
                    fg = "#ff0000", 
                    bg = "#ffff00", 
                    bold = true, 
                    standout = true,
                    reverse = true,
                  })
                else
                  vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#ff0000", bold = true })
                end
                vim.defer_fn(flash, 300)
              end
            end
            flash()
          end
        end
      end,
    })

    -- Add sound effect for errors (if system supports it)
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
      callback = function(args)
        local bufnr = args.buf
        local diagnostics = vim.diagnostic.get(bufnr)
        for _, diagnostic in ipairs(diagnostics) do
          if diagnostic.severity == vim.diagnostic.severity.ERROR then
            -- Try to play a system sound for errors
            vim.defer_fn(function()
              local cmd = ""
              if vim.fn.has("mac") == 1 then
                cmd = "afplay /System/Library/Sounds/Basso.aiff"
              elseif vim.fn.has("unix") == 1 then
                cmd = "paplay /usr/share/sounds/alsa/Front_Left.wav 2>/dev/null || echo -e '\a'"
              end
              if cmd ~= "" then
                vim.fn.system(cmd .. " &")
              end
            end, 100)
            break -- Only play sound once per diagnostic change
          end
        end
      end,
    })

    -- Enhanced statusline for diagnostics
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
      callback = function(args)
        local bufnr = args.buf
        local diagnostics = vim.diagnostic.get(bufnr)
        local error_count = 0
        local warn_count = 0
        
        for _, diagnostic in ipairs(diagnostics) do
          if diagnostic.severity == vim.diagnostic.severity.ERROR then
            error_count = error_count + 1
          elseif diagnostic.severity == vim.diagnostic.severity.WARN then
            warn_count = warn_count + 1
          end
        end
        
        -- Update a global variable that can be used in statusline
        vim.g.diagnostic_status = ""
        if error_count > 0 then
          vim.g.diagnostic_status = "🚨" .. error_count
        end
        if warn_count > 0 then
          vim.g.diagnostic_status = vim.g.diagnostic_status .. " ⚠️" .. warn_count
        end
      end,
    })
  end,
}
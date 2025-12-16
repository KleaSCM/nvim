--styled notification system
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
    },
    views = {
      cmdline_popup = {
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = {
            Normal = "NormalFloat",
            FloatBorder = "DiagnosticInfo",
          },
        },
      },
      popupmenu = {
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = {
            Normal = "NormalFloat",
            FloatBorder = "DiagnosticInfo",
          },
        },
      },
      mini = {
        win_options = {
          winblend = 0,
          winhighlight = {
            Normal = "NormalFloat",
            FloatBorder = "FloatBorder",
            FloatTitle = "FloatTitle",
          },
        },
      },
      notify = {
        win_options = {
          winblend = 0,
          winhighlight = {
            Normal = "NormalFloat",
            FloatBorder = "DiagnosticInfo",
          },
        },
        border = {
          style = "rounded",
          padding = { 1, 2 },
        },
      },
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    {
      "rcarriga/nvim-notify",
      opts = {
        background_colour = "#1a1a2e",
        fps = 60,
        level = "INFO",
        minimum_width = 50,
        max_width = 80,
        max_height = 10,
        render = "compact",
        stages = "fade_in_slide_out",
        timeout = 3000,
        top_down = false,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "",
          WARN = "",
        },
        on_open = function(win)
          -- Add styling
          vim.api.nvim_win_set_config(win, {
            border = "rounded",
            title = "  ✨ Notification  ",
            title_pos = "center",
          })
        end,
      },
    },
  },
}
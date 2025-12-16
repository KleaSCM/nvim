 -- AI coding assistance with feminine styling
return {
  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  -- Alternative: Codeium (free AI coding assistant) - configured for blink.cmp
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "InsertEnter",
    opts = {
      enable_blink = true, -- Use blink instead of cmp
      virtual_text = {
        enabled = true,
        manual = false,
        filetypes = {
          markdown = true,
          help = true,
        },
      },
    },
  },

  -- AI assistant with feminine styling
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").use("copilot", {
            schema = {
              model = {
                default = "gpt-4o",
                choices = { "gpt-4o", "gpt-4o-mini" },
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "copilot",
          roles = {
            user = "👩‍💻",
            llm = "🤖",
          },
          variables = {
            ["buffer"] = {
              callback = "codecompanion.variables.buffer",
              description = "Shared buffer",
              opts = {
                contains_code = true,
              },
            },
          },
          slash_commands = {
            ["file"] = {
              callback = "codecompanion.slash_commands.file",
              description = "Insert file contents",
              opts = {
                contains_code = true,
              },
            },
          },
          keymaps = {
            close = {
              modes = { n = "<C-c>", i = "<C-c>" },
              callback = "keymaps.close",
              description = "Close Chat",
            },
            send = {
              modes = { n = { "<leader>cs" }, i = "<leader>cs" },
              callback = "keymaps.send",
              description = "Send",
            },
          },
        },
        inline = {
          adapter = "copilot",
        },
      },
      display = {
        chat = {
          show_settings = true,
          show_references = true,
          start_in_insert_mode = false,
        },
        action_palette = {
          provider = "telescope",
        },
      },
      opts = {
        log_level = "DEBUG",
      },
    },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat<cr>", desc = "  AI Chat  " },
      { "<leader>ai", "<cmd>CodeCompanionInline<cr>", desc = "  AI Inline  " },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "  AI Actions  " },
      { "<leader>cc", "<cmd>lua require('config.ai').close_chat()<cr>", desc = "  AI Chat Close  " },
    },
  },

  -- Configure blink.cmp to work with Copilot
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        -- Add Copilot as a completion source
        copilot = {
          name = "copilot",
          module = "blink.cmp.sources.copilot",
          enabled = true,
          transform_items = function(_, items)
            -- Transform Copilot suggestions if needed
            return items
          end,
        },
      },
    },
  },

  -- Which-key integration for AI
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>a", group = "  AI Assistant  " },
      },
    },
  },
}
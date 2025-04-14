return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<leader>t]],
        direction = "vertical",
        float_opts = {
          border = "curved",
          width = function() return math.floor(vim.o.columns * 0.4) end,
          height = function() return vim.o.lines end,
        },
        on_open = function(term)
          vim.cmd("wincmd L")
          vim.cmd("wincmd =")
        end,
        on_close = function(term)
          vim.cmd("wincmd =")
        end,
      })

      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
      })

      vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
      vim.keymap.set("n", "<leader>g", function() lazygit:toggle() end, { desc = "Toggle lazygit" })

      local function resize_terminal(direction)
        local terms = require("toggleterm.terminal").get_all()
        for _, term in ipairs(terms) do
          if term:is_open() then
            if direction == "left" then
              vim.cmd("vertical resize -5")
            elseif direction == "right" then
              vim.cmd("vertical resize +5")
            end
          end
        end
      end

      vim.keymap.set("n", "<leader><Left>", function() resize_terminal("left") end, { desc = "Decrease terminal width" })
      vim.keymap.set("n", "<leader><Right>", function() resize_terminal("right") end, { desc = "Increase terminal width" })

      local main_term = Terminal:new({
        direction = "vertical",
        on_open = function(term)
          vim.cmd("wincmd L")
          vim.cmd("wincmd =")
        end,
      })

      local second_term = Terminal:new({
        direction = "vertical",
        on_open = function(term)
          vim.cmd("wincmd L")
          vim.cmd("wincmd =")
        end,
      })

      local third_term = Terminal:new({
        direction = "vertical",
        on_open = function(term)
          vim.cmd("wincmd L")
          vim.cmd("wincmd =")
        end,
      })

      vim.keymap.set("n", "<leader>2", function() second_term:toggle() end, { desc = "Toggle second terminal" })
      vim.keymap.set("n", "<leader>3", function() third_term:toggle() end, { desc = "Toggle third terminal" })

      vim.keymap.set("n", "<leader>tc", function()
        local terms = require("toggleterm.terminal").get_all()
        for _, term in ipairs(terms) do
          if term:is_open() then
            term:close()
          end
        end
      end, { desc = "Close all terminals" })
    end,
  },
} 
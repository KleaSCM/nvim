return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.3 -- 30% of window width
      end
    end,
    -- open mapping
    open_mapping = [[<c-\>]],
    -- on open or close
    on_open = function()
      -- Enter normal mode when terminal opens
      vim.cmd("startinsert")
    end,
    on_close = function()
      -- Return to normal mode when terminal closes
      vim.cmd("stopinsert")
    end,
    -- highlights
    highlights = {
      -- highlights which map to a highlight group name and a table of it's values
      Normal = {
        guibg = "#1e1e2e",
      },
      NormalFloat = {
        link = "Normal",
      },
      FloatBorder = {
        guifg = "#89b4fa",
        guibg = "#1e1e2e",
      },
    },
    -- shading factor for opacity
    shading_factor = 2,
    -- direction: 'vertical' | 'horizontal' | 'tab' | 'float'
    direction = "vertical",
    -- whether to persist the terminal
    persist_size = true,
    persist_mode = true,
    -- shell to use
    shell = vim.o.shell,
    -- auto close when terminal process exits
    auto_close = true,
    -- start in insert mode
    start_in_insert = true,
    -- winbar
    winbar = {
      enabled = false,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end,
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- Set up terminal keymaps
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

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    -- Custom terminal commands
    local Terminal = require("toggleterm.terminal").Terminal

    -- Horizontal terminal
    local horizontal_term = Terminal:new({
      direction = "horizontal",
      hidden = true,
      on_open = function()
        vim.cmd("startinsert")
      end,
    })

    -- Vertical terminal
    local vertical_term = Terminal:new({
      direction = "vertical",
      hidden = true,
      on_open = function()
        vim.cmd("startinsert")
      end,
    })

    -- Tab terminal
    local tab_term = Terminal:new({
      direction = "tab",
      hidden = true,
      on_open = function()
        vim.cmd("startinsert")
      end,
    })

    -- Keymaps for different terminal directions
    vim.keymap.set("n", "<leader>th", function()
      horizontal_term:toggle()
    end, { desc = "Terminal Horizontal Split" })

    vim.keymap.set("n", "<leader>tv", function()
      vertical_term:toggle()
    end, { desc = "Terminal Vertical Split" })

    vim.keymap.set("n", "<leader>tt", function()
      tab_term:toggle()
    end, { desc = "Terminal Tab" })

    vim.keymap.set("n", "<leader>tf", function()
      require("toggleterm.terminal").Terminal:new({ direction = "float" }):toggle()
    end, { desc = "Terminal Float" })

    -- Simple terminal toggle that reuses the same instance
    local main_terminal = Terminal:new({
      direction = "vertical",
      hidden = true,
      on_open = function()
        vim.cmd("startinsert")
      end,
    })

    vim.keymap.set("n", "<leader>t", function()
      main_terminal:toggle()
    end, { desc = "Toggle Terminal" })

    -- Lazygit in terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      direction = "float",
      hidden = true,
      on_open = function()
        vim.cmd("startinsert")
      end,
    })

    vim.keymap.set("n", "<leader>gg", function()
      lazygit:toggle()
    end, { desc = "Lazygit" })

    -- Node REPL in terminal
    local node = Terminal:new({
      cmd = "node",
      direction = "horizontal",
      hidden = true,
      on_open = function()
        vim.cmd("startinsert")
      end,
    })

    vim.keymap.set("n", "<leader>tn", function()
      node:toggle()
    end, { desc = "Node REPL" })

    -- Python REPL in terminal
    local python = Terminal:new({
      cmd = "python3",
      direction = "horizontal",
      hidden = true,
      on_open = function()
        vim.cmd("startinsert")
      end,
    })

    vim.keymap.set("n", "<leader>tp", function()
      python:toggle()
    end, { desc = "Python REPL" })
  end,
}
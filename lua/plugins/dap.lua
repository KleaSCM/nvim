return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui" },
    keys = { "<F5>", "<F10>", "<F11>", "<F12>" },
    config = function()
      local ok_dap, dap = pcall(require, "dap")
      if not ok_dap then
        vim.notify("nvim-dap not found", vim.log.levels.WARN)
        return
      end
      local ok_ui, dapui = pcall(require, "dapui")
      if ok_ui then
        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
      end

      -- Minimal keymaps
      vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "DAP Continue" })
      vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "DAP Step Over" })
      vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "DAP Step Into" })
      vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "DAP Step Out" })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    config = true,
  },
}

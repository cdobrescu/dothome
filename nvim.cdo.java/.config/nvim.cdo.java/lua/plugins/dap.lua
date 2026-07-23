return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()
    require("nvim-dap-virtual-text").setup()

    -- Automatically open/close DAP UI when debugging starts/ends
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- DAP Keymaps
    local map = vim.keymap.set
    map("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    map("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
    map("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
    map("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
    map("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    map("n", "<leader>B", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Debug: Set Conditional Breakpoint" })
    map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle DAP UI" })
  end,
}


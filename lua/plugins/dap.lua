return {
  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      -- Add your keymaps for debugging here
      { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
      { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
      { "<leader>do", "<cmd>DapStepOver<cr>", desc = "Step Over" },
      { "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step Into" },
      { "<leader>dO", "<cmd>DapStepOut<cr>", desc = "Step Out" },
    },
    config = function()
      -- Copy your dap setup from after/plugin/dap.lua
    end,
  },
--  {
--    "jay-babu/mason-nvim-dap.nvim",
--    event = "VeryLazy",
--    dependencies = {
--      "williamboman/mason.nvim",
--      "mfussenegger/nvim-dap",
--    },
--    config = function()
--      require("mason-nvim-dap").setup({
--        automatic_installation = true,
--        
--        ensure_installed = {
--          "python",
--          "cppdbg",
--        }
--      })
--    end
--  },
  {
    'mfussenegger/nvim-dap-python',
    ft = "python", -- Only load for Python files
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },
  {
    "julianolf/nvim-dap-lldb",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = { "c", "cpp", "rust" }, -- Only load for these filetypes
    config = function()
      require("dap-lldb").setup()
    end
  },
}

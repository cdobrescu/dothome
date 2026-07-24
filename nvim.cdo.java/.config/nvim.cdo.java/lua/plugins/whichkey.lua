return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>f",  group = "Find" },
      { "<leader>d",  group = "Debug" },
      { "<leader>o",  group = "Options" },
      { "<leader>b",  group = "Breakpoint" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}

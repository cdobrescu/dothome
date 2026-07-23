return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        file_ignore_patterns = { "target/", "build/", ".git/", ".gradle/", ".settings/" },
      },
    })

    telescope.load_extension("fzf")

    -- Global Keymaps
    local map = vim.keymap.set
    map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    map("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    map("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
    map("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
    map("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find Document Symbols" })
    map("n", "<leader>fw", builtin.lsp_workspace_symbols, { desc = "Find Workspace Symbols" })
  end,
}

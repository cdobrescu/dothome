return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = { "java", "lua", "vim", "vimdoc", "xml", "yaml", "json" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}

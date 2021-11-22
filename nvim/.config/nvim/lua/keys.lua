------------------- HELPERS ---------------------------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options


local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader = ' '
g.maplocalleader = '\\'

-------------------- TELESCOPE ------------------------------

local wk = require("which-key")
-- As an example, we will the create following mappings:
--  * <leader>ff find files
--  * <leader>fr show recent files
--  * <leader>fb Foobar
-- we'll document:
--  * <leader>fn new file
--  * <leader>fe edit file
-- and hide <leader>1

wk.register(
{
  f = {
    name = "file", -- optional group name
    f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
    g = { "<cmd>Telescope live_grep<cr>", "Live grep" }, -- create a binding with label
    b = { "<cmd>Telescope buffers<cr>", "Buffers" }, -- create a binding with label
    h = { "<cmd>Telescope help_tags<cr>", "Help tags" }, -- create a binding with label
    -- r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap=false, buffer = 123 }, -- additional options for creating the keymap
    -- n = { "New File" }, -- just a label. don't create any mapping
    -- e = "Edit File", -- same as above
    -- ["1"] = "which_key_ignore",  -- special label to hide it in the popup
    -- b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
  },
  l = {
    name = "lsp", -- optional group name
    K = { '<cmd>lua vim.lsp.buf.hover()<CR>', "Hover" }, -- create a binding with label
    h = { '<cmd>lua vim.lsp.buf.hover()<CR>', "Hover" }, -- create a binding with label
    --'<c-]>' = { '<cmd>lua vim.lsp.buf.definition()<CR>', 'Goto Def'},
    d = { '<cmd>lua vim.lsp.buf.definition()<CR>', 'Goto Def'},
    s = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Signature'},
    -- r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap=false, buffer = 123 }, -- additional options for creating the keymap
    -- n = { "New File" }, -- just a label. don't create any mapping
    -- e = "Edit File", -- same as above
    -- ["1"] = "which_key_ignore",  -- special label to hide it in the popup
    -- b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
  },
}, 
{ prefix = "<leader>" })


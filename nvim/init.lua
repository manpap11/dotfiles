--  _       _ _         _
-- (_)     (_) |       | |
--  _ _ __  _| |_      | |_   _  __ _
-- | | '_ \| | __|     | | | | |/ _` |
-- | | | | | | |_   _  | | |_| | (_| |
-- |_|_| |_|_|\__| (_) |_|\__,_|\__,_|
--
-- Created by manpap

require("config.lazy")
require("general")
require("config.lsp.lua")

local o = vim.o
local cmd = vim.cmd
local api = vim.api
local diag = vim.diagnostic

-- Adding mouse support
o.mouse = "a"

-- Numbering
o.number = true
o.relativenumber = true

-- Indentation
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true
o.smartindent = true

-- Text Wrap
o.wrap = true

-- Searching
o.hlsearch = false
o.incsearch = true

-- Scrolling
o.scrolloff = 8

-- Faster nvim update
o.updatetime = 50

-- Fancy Colors
cmd([[colorscheme tokyonight]])

-- Transparent Background
api.nvim_set_hl(0, "Normal", { bg = "none" })
api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- LSP
diag.config({
    virtual_text = true,
    --virtual_lines = true,
    underline = true,
})

--  _       _ _         _
-- (_)     (_) |       | |
--  _ _ __  _| |_      | |_   _  __ _
-- | | '_ \| | __|     | | | | |/ _` |
-- | | | | | | |_   _  | | |_| | (_| |
-- |_|_| |_|_|\__| (_) |_|\__,_|\__,_|
--
-- Created by manpap

require("general")
require("config.lazy")

local o = vim.o
local cmd = vim.cmd

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

local g = vim.g
local cmd = vim.cmd
local keyset = vim.keymap.set

-- Leader mappings
g.mapleader = " "
g.maplocalleader = "\\"


-- Window Splits Shortcuts
keyset("n", "<leader>L", "<C-w>v", { desc = "Split window Right" })
keyset("n", "<leader>J", "<C-w>s", { desc = "Split window Below" })

-- Windows Movement Shortcuts
keyset("n", "<leader>l", "<C-w>l", { desc = "Move to Right window" })
keyset("n", "<leader>h", "<C-w>h", { desc = "Move to Left window" })
keyset("n", "<leader>j", "<C-w>j", { desc = "Move to the window Below" })
keyset("n", "<leader>k", "<C-w>k", { desc = "Move to window Up" })

-- Visual Mode Mods
keyset("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection up when highlighted" })
keyset("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection down when highlighted"})

-- Clipboard
keyset("n", "<leader>y", "\"+y")
keyset("v", "<leader>y", "\"+y")
keyset("n", "<leader>Y", "\"+Y")

-- Vim Keybind Remaps
keyset("i", "ii", "<Esc>")
keyset("n", "<C-d>", "<C-d>zz")
keyset("n", "<C-u>", "<C-u>zz")

-- =================
-- Funtion Shortcuts
-- =================

-- Netrw Shortcut
keyset("n", "<leader>pv", cmd.Ex)

-- Lazy.nvim PM Pop Up
keyset("n", "<leader>pm", cmd.Lazy)

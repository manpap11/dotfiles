require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Git branch switcher
map("n", "<leader>gb", function()
  require("telescope.builtin").git_branches()
end, { desc = "Git switch branch" })

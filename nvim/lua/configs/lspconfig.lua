require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright", "clangd" }
vim.lsp.enable(servers)

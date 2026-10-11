require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright", "clangd", "ts_ls" }
vim.lsp.enable(servers)

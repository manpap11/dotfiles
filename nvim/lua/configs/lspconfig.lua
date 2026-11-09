require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright", "clangd", "ts_ls", "gopls" }
vim.lsp.enable(servers)

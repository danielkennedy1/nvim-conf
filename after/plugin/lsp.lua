local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.setup()

lsp.on_attach = function(client, bufnr)
  require("lsp-status").on_attach(client)
  local opts = { buffer = bufnr, remap = false }

end

-- Mason - LSP, DAP, Linter and Formatters
require("mason").setup {
  plugins = {
    "dan.remap",
    "dan.packer",
    "dan.nvim-tree",
    "dan.command",
    "dan.conf",
  },
  treesitter = {
    compilers = { "zig" },
  },
}

-- Navic - tells you where you are in the code
local navic = require("nvim-navic")

require("lspconfig").clangd.setup {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end
}



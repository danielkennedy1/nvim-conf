local lsp = require("lsp-zero")

-- Navic - tells you where you are in the code
local navic = require("nvim-navic")
navic.setup()

lsp.preset("recommended")
lsp.setup()

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

require("mason-lspconfig").setup({
  handlers = {
	  function(server_name)
		  require('lspconfig')[server_name].setup({
			  on_attach = function(client, bufnr)
				  -- Navic - tells you where you are in the code. Admittedly no idea if its working
				  navic.attach(client, bufnr)
				  -- Few keymaps and that cheers ThePrimeagen
				  local opts = { noremap = true, silent = true, buffer = bufnr}
				  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts, {desc= "Go to definition"})
				  vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts, {desc= "Go to definition"})
				  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
				  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
				  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
				  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
				  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
				  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
				  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
				  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
				  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
			  end
		  })
	  end,
  },
})


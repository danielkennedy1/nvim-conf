local lsp = require("lsp-zero")

-- Navic - tells you where you are in the code
local navic = require("nvim-navic")
navic.setup {
    icons = {
        File          = "󰈙 ",
        Module        = " ",
        Namespace     = "󰌗 ",
        Package       = " ",
        Class         = "󰌗 ",
        Method        = "󰆧 ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = "󰕘",
        Interface     = "󰕘",
        Function      = "󰊕 ",
        Variable      = "󰆧 ",
        Constant      = "󰏿 ",
        String        = "󰀬 ",
        Number        = "󰎠 ",
        Boolean       = "◩ ",
        Array         = "󰅪 ",
        Object        = "󰅩 ",
        Key           = "󰌋 ",
        Null          = "󰟢 ",
        EnumMember    = " ",
        Struct        = "󰌗 ",
        Event         = " ",
        Operator      = "󰆕 ",
        TypeParameter = "󰊄 ",
    },
    lsp = {
        auto_attach = false,
        preference = nil,
    },
    highlight = false,
    separator = " > ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true,
    lazy_update_context = false,
    click = false,
    format_text = function(text)
        return text
    end,
}

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

				  -- Gotos
				  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
				  vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
				  vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)

				  -- Actions "l" for LSP + ..
				  vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
				  vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.hover() end, opts)
				  vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
				  vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
				  vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)

				  -- Diagnostics
				  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
				  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

				  -- Signature help in insert mode
				  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
			  end
		  })
	  end,
  },
})


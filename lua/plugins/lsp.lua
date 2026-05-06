return {
    { 'williamboman/mason.nvim', config = true },
    { 'williamboman/mason-lspconfig.nvim', config = true },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(ev)
                    local opts = { noremap = true, silent = true, buffer = ev.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>lws", vim.lsp.buf.workspace_symbol, opts)
                    vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
                end,
            })

            -- Override clangd cmd to use nix path
            vim.lsp.config('clangd', {
                cmd = {
                    "/run/current-system/sw/bin/clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=never",
                    "--query-driver=/run/current-system/sw/bin/clang,/run/current-system/sw/bin/clang++",
                }
            })

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.tf", "*.tfvars" },
                callback = function() vim.lsp.buf.format() end,
            })
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                sources = { { name = 'nvim_lsp' } },
                mapping = {
                    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<C-q>'] = cmp.mapping.abort(),
                },
                snippet = {
                    expand = function(args) require('luasnip').lsp_expand(args.body) end,
                },
            })
        end,
    },
}

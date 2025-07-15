return {
    {
        'VonHeikemen/lsp-zero.nvim',
        -- branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            -- Ordering so mason doesn't complain
            { 'williamboman/mason.nvim',           lazy = true },
            { 'williamboman/mason-lspconfig.nvim', lazy = true },
        },
        config = function()

            local lsp = require('lsp-zero')
            lsp.setup()

            local cmp = require('cmp')
            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                mapping = {
                    -- Navigate between completion items with <Tab> and <S-Tab>
                    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = 'select' }),

                    -- Confirm completion with <Enter>,
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),

                    -- Close completion with <C-q>
                    ['<C-q>'] = cmp.mapping.abort(),
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
            })

            require("mason").setup()
            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({
                            on_attach = function(client, bufnr)
                                print("LSP attached: " .. client.name .. " to buffer: " .. bufnr)
                                local opts = { noremap = true, silent = true, buffer = bufnr }
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
                                vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
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

            vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                pattern = { "*.tf", "*.tfvars" },
                callback = function()
                    vim.lsp.buf.format()
                end,
            })
        end,
    },
}

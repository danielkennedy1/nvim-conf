return {
    {
        'VonHeikemen/lsp-zero.nvim',
        -- branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},

            -- Ordering so mason doesn't complain
            {'williamboman/mason.nvim', lazy = true},
            {'williamboman/mason-lspconfig.nvim', lazy = true},
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


          require("lspconfig").pyright.setup({
              settings = {
                  python = {
                      analysis = {
                          autoSearchPaths = true,
                          useLibraryCodeForTypes = true,
                          diagnosticMode = "workspace",
                      },
                  },
              },
              cmd = { "pyright-langserver", "--stdio", "--venvPath=." }
          }
          )

          require("lspconfig").vacuum.setup({})
          require("lspconfig").terraformls.setup({})

          vim.api.nvim_create_autocmd({"BufWritePre"}, {
              pattern = {"*.tf", "*.tfvars"},
              callback = function()
                  vim.lsp.buf.format()
              end,
          })
        end,
    },
}

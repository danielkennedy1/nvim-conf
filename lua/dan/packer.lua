-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        requires = { { 'nvim-lua/plenary.nvim' } } }
    use(
        { "bluz71/vim-nightfly-colors", as = "nightfly", config = function() vim.cmd("colorscheme nightfly") end }
    )
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use({ "theprimeagen/harpoon", branch = "harpoon2", requires = { { "nvim-lua/plenary.nvim" } } })
    use("github/copilot.vim")
    use {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup()
        end
    }
    use("hiphish/rainbow-delimiters.nvim")
    use("nvim-tree/nvim-tree.lua")
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 800
            require("which-key").setup {}
        end
    }
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
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
        }
    }
    use({
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        config = function()
            require("barbecue").setup()
        end,
    })
    use('tpope/vim-fugitive')
    use("akinsho/toggleterm.nvim")
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {
                check_ts = true,
            }

            -- cmp setup fo autopairs

            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end
    }
    use {
        "p00f/clangd_extensions.nvim",
    }
    use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim", config = function()
        require("todo-comments").setup {}
    end }
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python'
    use { 'mhartington/formatter.nvim' }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use({
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup {
                condition = function(buf)
                    -- Don't close harpoon quick menu
                    if vim.bo[buf].filetype == "harpoon" then
                        return false
                    end
                end
            }
        end,
    })
end)

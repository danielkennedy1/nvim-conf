-- FIXME: These could be interfering with one another
return {
    {
        "SmiteshP/nvim-navic",
        name = "navic",
        config = function()
            require("nvim-navic").setup {
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
        end,

    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("barbecue").setup({
                attach_navic = true,
            })
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 800
            require("which-key").setup({})
        end,
    },
}

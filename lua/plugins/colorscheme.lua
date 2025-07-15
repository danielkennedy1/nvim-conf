return {
    {
        "bluz71/vim-nightfly-colors",
        name = "nightfly",
        lazy = false, -- load during startup
        config = function()
            vim.cmd("colorscheme nightfly")
        end,
    },
}

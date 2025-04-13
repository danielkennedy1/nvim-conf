return {
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false, -- load during startup
    --priority = 1000, -- load this before all other plugins
    config = function()
      vim.cmd("colorscheme nightfly")
    end,
  },
}

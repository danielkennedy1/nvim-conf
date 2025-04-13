return {
  {
    'nvim-treesitter/nvim-treesitter',
    --build = ':TSUpdate',
    -- Load when needed, but not at startup
    -- event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- Copy your treesitter setup from after/plugin/treesitter.lua
      require('nvim-treesitter.configs').setup({
        -- Your treesitter config here
        ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "python" }, -- Add languages you use
        sync_install = true,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })


      require 'nvim-treesitter.install'.compilers = { "gcc" }
    end
  },
  {
    'nvim-treesitter/playground',
    cmd = "TSPlaygroundToggle", -- Only load when the command is used
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
  {
    'hiphish/rainbow-delimiters.nvim',
  },
}

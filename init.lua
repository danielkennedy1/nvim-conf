-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Import your base configuration
require("dan")

-- Set leader key before lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup Lazy
require("lazy").setup("plugins", {
  change_detection = {
    -- automatically check for config file changes and reload
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
  checker = {
    -- check for plugin updates
    enabled = true,
    frequency = 86400, -- check once a day
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

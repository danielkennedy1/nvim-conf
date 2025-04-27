-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("dan")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("plugins", {
  change_detection = {
    enabled = true,
    notify = false,
  },
  checker = {
    enabled = true,
    frequency = 86400,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        -- TODO: Find out what the story is with these
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

fixbg()

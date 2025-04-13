return {
  {
    'tpope/vim-fugitive',
    cmd = { 
      "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove", "GRename"
    },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
    },
  },
}

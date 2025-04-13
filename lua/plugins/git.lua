return {
  -- Git integration with fugitive
  {
    'tpope/vim-fugitive',
    cmd = { 
      "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove", "GRename"
    }, -- Load on these commands
    keys = {
      -- Add your keymaps for fugitive here if you have any
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
    },
  },
}

vim.api.nvim_create_user_command(
  'Waq',
  function()
    vim.cmd('wa')   -- Write all buffers
    vim.cmd('qa')   -- Quit Neovim
  end,
  {}
)

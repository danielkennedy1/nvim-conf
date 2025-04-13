vim.api.nvim_create_user_command(
  'Waq',
  function()
    vim.cmd('wa')   -- Write all buffers
    vim.cmd('qa')   -- Quit Neovim
  end,
  {}
)
function fixbg()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

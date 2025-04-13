vim.g.vimtex_compiler_method = 'generic'
vim.g.vimtex_compiler_generic = {
  name = 'custom',
  command = './build.sh',
  options = { '--keep-going' }, -- Add any extra arguments if needed
}

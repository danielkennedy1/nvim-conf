vim.g.mapleader = " "

-- VSCode-esque
-- Move lines up and down with Alt-j and Alt-k

vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==')

vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv")
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv")

-- Disable highlight
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Remap pane navigation, to accomodate for Harpoon
vim.api.nvim_set_keymap('n', '<C-Up>', '<cmd>wincmd k<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-Down>', '<cmd>wincmd j<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-Left>', '<cmd>wincmd h<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-Right>', '<cmd>wincmd l<CR>', { silent = true })

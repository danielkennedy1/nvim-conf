-- Disable Tab for accepting Copilot suggestion
vim.g.copilot_no_tab_map = true

-- Map Right Arrow to accept Copilot suggestion
vim.api.nvim_set_keymap('i', '<S-Tab>', '<Plug>(copilot-accept)', {silent = true})

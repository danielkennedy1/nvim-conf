local harpoon = require("harpoon")

harpoon:setup()
-- add to list
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add mark" })
-- look at list
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
-- navigate between marks
vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

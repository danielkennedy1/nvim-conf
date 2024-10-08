local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then return end

vim.cmd([[
  nnoremap - :NvimTreeToggle<CR>
]])

local keymap = vim.keymap -- for conciseness
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer
keymap.set("n", "<leader>E", ":NvimTreeFindFile<CR>") -- toggle file explorer

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this too

local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings for nvim-tree
    -- navigate
    vim.keymap.set('n', 'l', api.node.open.edit, opts("Open"))
    vim.keymap.set('n', 'o', api.node.open.edit, opts("Open"))
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts("Open"))
    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts("Close Directory"))
    -- vertical split
    vim.keymap.set('n', 'v', api.node.open.vertical, opts("Open: Vertical Split"))
    vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts("CD"))
    -- close without remembering to press 'q'
    vim.keymap.set('n', '<Esc>', api.tree.close, opts("Close"))
end

nvimtree.setup({
  on_attach = my_on_attach,
  disable_netrw = true,
  hijack_netrw = true,
  respect_buf_cwd = true,
  sync_root_with_cwd = true,
  view = {
    relativenumber = true,
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()

        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO

        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)

        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                         - vim.opt.cmdheight:get()
        return {
          border = "rounded",
          relative = "editor",
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
        end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
})


-- Line numbers
vim.api.nvim_exec(
	[[
		set number
	]],
	false
	)
-- set relative line numbers appropriately (outside insert mode)
vim.api.nvim_exec(
        [[
          augroup NumToggle
            autocmd!
            autocmd InsertEnter * set norelativenumber
            autocmd InsertLeave * set relativenumber
          augroup END
          
          " Optionally set relative numbers for specific modes
          autocmd BufEnter,FocusGained,InsertLeave * if &buftype != 'terminal' | set relativenumber | endif
          autocmd BufLeave,FocusLost,InsertEnter * if &buftype != 'terminal' | set norelativenumber | endif
        ]],
        false
      )

-- Use system clipboard
vim.cmd [[
	set clipboard+=unnamedplus
]]

-- Borders for floating windows
vim.cmd [[
  hi FloatBorder guifg=white
]]

vim.cmd [[
    set signcolumn=yes
]]


-- Set tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

-- Get rid of swap and backup files
vim.opt.swapfile = false
vim.opt.backup = false

-- Search stuff
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.updatetime = 50

vim.opt.termguicolors = true


-- Set up Ripgrep as the grep program
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"

-- Set python privider
vim.g.python3_host_prog = "C:/Users/danie/AppData/Local/Programs/Python/Python312/python.exe"

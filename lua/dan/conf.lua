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

-- Enable powershell as default shell
vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

-- Borders for floating windows
vim.cmd [[
  hi FloatBorder guifg=white
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

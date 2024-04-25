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

-- Set clipboard manager
vim.g.clipboard = {
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
}

-- Enable powershell as default shell
vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]


local dap = require("dap")
dap.adapters.python = {
	type = "executable",
	command = "C:/Users/danie/.virtualenvs/debugpy/Scripts/python.exe",
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			local venv_path = os.getenv("VIRTUAL_ENV")
			if venv_path then
				return venv_path .. "/Scripts/python.exe"
			else
				return "C:/Users/danie/.virtualenvs/debugpy/Scripts/python.exe"
			end
		end,
	},
}

-- Keybindings
vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })


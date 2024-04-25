-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use(
	{ "bluz71/vim-nightfly-colors", as = "nightfly", config = function() vim.cmd("colorscheme nightfly") end}
	)
	use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
	use('nvim-treesitter/playground')
	use({"theprimeagen/harpoon", branch = "harpoon2", requires = { {"nvim-lua/plenary.nvim"} } })
	use("github/copilot.vim")
	use {
		'windwp/nvim-ts-autotag',
		config = function()
			require('nvim-ts-autotag').setup()
		end
	}
	use("hiphish/rainbow-delimiters.nvim")
	use("nvim-tree/nvim-tree.lua")
end)

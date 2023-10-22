local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	-- Packer can manage itself
	use({
		"wbthomason/packer.nvim",
		commit = "ea0cc3c59f67c440c5ff0bbe4fb9420f4350b9a3",
	})

	-- startup time for plugins
	use({
		"dstein64/vim-startuptime",
		commit = "454b3de856b7bd298700de33d79774ca9b9e3875",
	})

	use({
		"nvim-lualine/lualine.nvim",
		commit = "45e27ca739c7be6c49e5496d14fcf45a303c3a63",
		config = function()
			require("eskrest.plugin.lualine").setup()
		end,
	})

	use({
		"nvim-tree/nvim-web-devicons",
		commit = "56b3a6ce6d69329cbf603dd38ac59fb4d7774b01",
	})

	-- use 'preservim/nerdtree'
	use({
		"nvim-tree/nvim-tree.lua",
		commit = "949913f1860eb85024fa1967dbd89ac797777b0d",
		opt = true,
		cmd = { "NvimTreeToggle" },
		branch = "compat-nvim-0.7",
		config = function()
			require("eskrest.plugin.nvim-tree").setup()
		end,
	})

	-- colorscheme
	use({
		"navarasu/onedark.nvim",
		commit = "826fb77e9ca92d3c0f3d937328663d4a6dc7fee1",
		config = function()
			require('eskrest.plugin.onedark').setup()
	end,
	})

	use({
		"neovim/nvim-lspconfig",
		commit = "2df0fbdadd947cd2995566a0117b8802a9ba74f4",
		branch = "v0.1.5",
		requires = {
			{
				"williamboman/mason.nvim",
				commit = "d66c60e17dd6fd8165194b1d14d21f7eb2c1697a",
			},
			{
				"williamboman/mason-lspconfig.nvim",
				commit = "e2705063f395b44f676cd26596a11007a2cbd3bd",
			},
			{
				"hrsh7th/nvim-cmp",
				commit = "5dce1b778b85c717f6614e3f4da45e9f19f54435",
				config = function()
					require("eskrest.plugin.cmp").setup()
				end,
			},
			{
				"hrsh7th/cmp-buffer",
				commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
			},
			{
				"hrsh7th/cmp-path",
				commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
			},
			{
				"hrsh7th/cmp-nvim-lsp",
				commit = "44b16d11215dce86f253ce0c30949813c0a90765",
			},
			{
				"hrsh7th/cmp-nvim-lua",
				commit = "f12408bdb54c39c23e67cab726264c10db33ada8",
			},
			{
				"L3MON4D3/LuaSnip",
				commit = "cdbf6f41381e5ee4810b4b09284b603d8f18365d",
			},
			{
				"saadparwaiz1/cmp_luasnip",
				commit = "18095520391186d634a0045dacaa346291096566",
			},
			{
				"mhartington/formatter.nvim",
				commit = "34dcdfa0c75df667743b2a50dd99c84a557376f0",
				config = function()
					require("eskrest.plugin.formatter").setup()
				end,
			},
		},
		config = function()
			require("eskrest.plugin.lspconfig").setup()
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		commit = "4cccb6f494eb255b32a290d37c35ca12584c74d0",
		branch = "v0.7.2",
		run = ":TSUpdate",
		config = function()
			require("eskrest.plugin.treesitter").setup()
		end,
	})

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		commit = "b79cd6c88b3d96b0f49cb7d240807cd59b610cd8",
		branch = "0.1.0",
		requires = { {
			"nvim-lua/plenary.nvim",
			commit = "9ce85b0f7dcfe5358c0be937ad23e456907d410b",
		} },
		config = function()
			require("eskrest.plugin.telescope").setup()
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)

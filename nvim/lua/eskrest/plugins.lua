local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
	-- startup time for plugins
	"dstein64/vim-startuptime",

	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("eskrest.plugin.lualine").setup()
		end,
	},

	"nvim-tree/nvim-web-devicons",

	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	config = function()
	-- 		require("eskrest.plugin.nvim-tree").setup()
	-- 	end,
	-- },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			require("eskrest.plugin.neo-tree").setup()
		end,
	},

	-- colorscheme
	{
		"navarasu/onedark.nvim",
		config = function()
			require('eskrest.plugin.onedark').setup()
	end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				"hrsh7th/nvim-cmp",
				config = function()
					require("eskrest.plugin.cmp").setup()
				end,
			},
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			{
				"mhartington/formatter.nvim",
				config = function()
					require("eskrest.plugin.formatter").setup()
				end,
			},
		},
		config = function()
			require("eskrest.plugin.lspconfig").setup()
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("eskrest.plugin.treesitter").setup()
		end,
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sharkdp/fd",
		},
		config = function()
			require("eskrest.plugin.telescope").setup()
		end,
	},
})

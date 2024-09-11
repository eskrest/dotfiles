local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sharkdp/fd",
	},
}

function M.config()
	local loaded, telescope = pcall(require, "telescope")

	if not loaded then
		return
	end

	local defaults = {
		preview = false,
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
		},
	}

	require("telescope").setup({ defaults = defaults })

	-- telescope
	-- Find files using Telescope command-line sugar.
	local builtin = require("telescope.builtin")
	-- local actions = require('telescope.actions')
	vim.keymap.set("n", "<C-p>", function()
		builtin.find_files({
			hidden = true,
			preview = false,
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		})
	end, {})
	vim.keymap.set("n", "<C-f>", function()
		builtin.grep_string({ search = vim.fn.input("Grep > ") })
	end, {})
	vim.keymap.set("n", "<leader>th", builtin.help_tags, {})
	vim.keymap.set("n", "<leader>tb", builtin.buffers)
	vim.keymap.set("n", "<leader>tm", builtin.keymaps)
	-- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
end

return M

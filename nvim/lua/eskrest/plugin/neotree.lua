local M = {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
}

function M.config()
	local loaded, neoTree = pcall(require, "neo-tree")

	if not loaded then
		return
	end

	neoTree.setup({
		sort_case_insensitive = false,
		window = {
			width = 40,
		},
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
			},
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
				-- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
		},
		git_status = {
			symbols = {
				-- Change type
				added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "✖", -- this can only be used in the git_status source
				renamed = "󰁕", -- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored = "",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
			},
		},
		window = {
			mappings = {
				["/"] = "",
				["z"] = "",
			},
		},
	})
end

return M

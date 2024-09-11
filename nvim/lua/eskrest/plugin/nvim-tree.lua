local M = {}

M.setup = function()
	local loaded, nvimTree = pcall(require, "nvim-tree")

	if not loaded then
		return
	end

	nvimTree.setup({
		sort_by = "case_sensitive",
		view = {
			width = 30,
		},
		filters = {
			dotfiles = false,
		},
		git = {
			enable = true,
			ignore = false,
			timeout = 500,
		},
	})
end

return M

local M = {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
}

function M.config()
	local loaded, treesitter = pcall(require, "nvim-treesitter.configs")

	if not loaded then
		return
	end

	treesitter.setup({
		ensure_installed = { "html", "lua", "php", "javascript", "typescript", "vue", "tsx" },
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
	})
end

return M

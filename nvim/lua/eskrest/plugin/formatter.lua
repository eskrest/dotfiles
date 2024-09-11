local M = {}

M.setup = function()
	local loaded, formatter = pcall(require, 'formatter')

	if not loaded then
		return
	end

	formatter.setup({
		logging = true,
		log_level = vim.log.levels.WARN,
		filetype = {
			javascript = {
				require("formatter.filetypes.javascript").prettier,
			},
			javascriptreact = {
				require("formatter.filetypes.javascriptreact").prettier,
			},
			typescript = {
				require("formatter.filetypes.typescript").prettier,
			},
			typescriptreact = {
				require("formatter.filetypes.typescriptreact").prettier,
			},
			json = {
				require("formatter.filetypes.json").prettier,
			},
			vue = {
				require("formatter.filetypes.vue").prettier,
			},
			html = {
				require("formatter.filetypes.html").prettier,
			},
			lua = {
				require("formatter.filetypes.lua").stylua,
			},
		},
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	})
end

return M

-- fix for sass files indentation
vim.api.nvim_create_autocmd("FileType", {
	pattern = "sass",
	callback = function()
		vim.opt.shiftwidth = 4
	end,
})

-- vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
-- 	pattern = '*.tsx',
-- 	callback = function()
-- 		vim.opt.filetype = 'typescriptreact'
-- 	end
-- })

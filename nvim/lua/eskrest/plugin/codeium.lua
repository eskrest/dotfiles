local M = {
	"Exafunction/codeium.vim",
	event = "BufEnter",
}

function M.config()
	vim.keymap.set('i', '<A-Tab>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
	-- vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
	-- vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
	-- vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
end

return M

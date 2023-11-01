local opt = vim.opt
local g = vim.g

-- vim.cmd('colorscheme onedark')
-- vim.cmd('colorscheme ron')

-- opt.termguicolors = true
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
opt.undodir = vim.fn.expand('~/.config/nvim/undodir')
opt.swapfile = false
opt.undofile = true
opt.backup = false

opt.list = true
opt.syntax = 'on'
opt.listchars:append({tab = '│ ', trail = '.'})
opt.path:append({'.', '**'})
opt.wildignore:append('**/node_modules/**')
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.nu = true
opt.relativenumber = true
opt.foldmethod = 'indent'
opt.foldenable = false
opt.mouse = 'a'
opt.cursorline = true
opt.cursorcolumn = true
opt.wrap = true
opt.scrolloff = 1
opt.signcolumn = "yes"
opt.updatetime = 50
opt.autoindent = true
opt.ignorecase = true
-- opt.iskeyword = '@,48-57,192-255'

vim.api.nvim_set_hl(0, 'CursorLine', { cterm=none, ctermbg=237, ctermfg=none })
vim.api.nvim_set_hl(0, 'Normal', { bg=none })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg=none })
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg=none })

vim.api.nvim_create_autocmd("FileType", {
	pattern = 'php',
	callback = function()
		vim.opt.autoindent = true
		vim.opt.filetype = 'html'
	end
})

-- vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
-- 	pattern = '*.tsx',
-- 	callback = function()
-- 		vim.opt.filetype = 'typescriptreact'
-- 	end
-- })

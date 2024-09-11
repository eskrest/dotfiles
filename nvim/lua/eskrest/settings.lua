-- vim.cmd('colorscheme onedark')
-- vim.cmd('colorscheme ron')
-- vim.opt.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undodir")
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.backup = false
-- this would make that y, p, C, etc.
-- put the thing into the system clipboard
-- vim.opt.clipboard = 'unnamedplus'
vim.opt.list = true
vim.opt.syntax = "on"
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.pumblend = 10
vim.opt.listchars:append({ tab = "│ ", multispace = "│   ", trail = "." })
vim.opt.path:append({ ".", "**" })
vim.opt.wildignore:append("**/node_modules/**")
-- vim.opt.tabstop = 2
vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 2
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.wrap = true
vim.opt.scrolloff = 1
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.autoindent = true
vim.opt.ignorecase = true
-- vim.opt.iskeyword = '@,48-57,192-255'
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications

vim.api.nvim_set_hl(0, "CursorLine", { cterm = none, ctermbg = 237, ctermfg = none })
vim.api.nvim_set_hl(0, "Normal", { bg = none })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = none })
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg=none })
-- experimental
-- add russian keymap
-- press Ctrl+^ to toggle
vim.cmd("set keymap=russian-jcukenwin")
vim.cmd("set iminsert=0")
vim.cmd("set imsearch=0")

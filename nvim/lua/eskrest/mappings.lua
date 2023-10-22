local g = vim.g
local keymap = vim.keymap

g.mapleader = " "

keymap.set("n", "<leader>h", "<C-w>h")
keymap.set("n", "<leader>j", "<C-w>j")
keymap.set("n", "<leader>k", "<C-w>k")
keymap.set("n", "<leader>l", "<C-w>l")
keymap.set("n", "<leader>f", "<C-w><Bar>")
keymap.set("n", "<leader>d", "<C-w>=")
keymap.set("n", "<leader>o", ":vertical resize -30<CR>")
keymap.set("n", "<leader>i", ":vertical resize +30<CR>")
keymap.set("n", "<leader>v", ":vsplit<CR>")
keymap.set("n", "<Left>", "<Nop>")
keymap.set("n", "<Right>", "<Nop>")
keymap.set("n", "<Up>", "<Nop>")
keymap.set("n", "<Down>", "<Nop>")
keymap.set("n", "<Esc>", ":noh<CR>")
-- keymap.set('n', 'q', '<Nop>')
-- keymap.set('n', 'Q', '<Nop>')
keymap.set("n", "<leader>gtc", ":e ~/.config/nvim/<CR>")
keymap.set("n", "<leader>bn", ":bn<CR>")
keymap.set("n", "<leader>bp", ":bp<CR>")
keymap.set("n", "<leader>x", ":bd<CR>")
keymap.set("n", "<leader>r;", ":RemoveAllSemicolons<CR>")
keymap.set("n", "<C-s>", function()
	local path = vim.fn.expand('%:p:h')
	local file_name = vim.fn.input('save to: ', path)
	vim.cmd(':w '..file_name)
end)
keymap.set("i", "<C-h>", "<esc>gUiw`]a")
keymap.set("i", "<C-l>", "<esc>guiw`]a")
keymap.set("i", "<Left>", "<Nop>")
keymap.set("i", "<Right>", "<Nop>")
keymap.set("i", "<Up>", "<Nop>")
keymap.set("i", "<Down>", "<Nop>")

-- Paste in visual mode without copying
keymap.set("x", "p", 'pgvy')
keymap.set("v", "<C-c>", '"+y')

-- Plugins

-- NERDTree
-- keymap.set('n', '<leader>n', ':NERDTreeToggle<CR>')
keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>")
-- let NERDTreeShowHidden=1

-- Fuzzy Finder
-- keymap.set('n', '<C-p>', ':FuzzyOpen<CR>')

-- RipGrep
-- keymap.set('n', '<C-f>', ':Rg --hidden ')

-- Not Git fugitive
-- keymap.set('n', '<leader>g', ':G<CR>')
keymap.set("n", "<leader>ga", ":!git add .<CR>")
keymap.set("n", "<leader>gc", ':!git commit -m ""<Left>')
-- keymap.set('n', '<leader>gb', ':G blame<CR>')
keymap.set("n", "<leader>gs", ":!git status<CR>")
-- keymap.set('n', '<leader>gd', ':Gvdiffsplit<CR>')
keymap.set("n", "<leader>gp", ":!git push origin ")
-- prettier
keymap.set("n", "<leader>pr", ":Format<cr>")

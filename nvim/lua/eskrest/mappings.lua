local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>h", "<C-w>h", opts)
vim.keymap.set("n", "<leader>j", "<C-w>j", opts)
vim.keymap.set("n", "<leader>k", "<C-w>k", opts)
vim.keymap.set("n", "<leader>l", "<C-w>l", opts)
vim.keymap.set("n", "<leader>f", "<C-w><Bar>", opts)
vim.keymap.set("n", "<leader>d", "<C-w>=", opts)
vim.keymap.set("n", "<leader>o", ":vertical resize -30<CR>", opts)
vim.keymap.set("n", "<leader>i", ":vertical resize +30<CR>", opts)
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", opts)
vim.keymap.set("n", "<Left>", "<Nop>", opts)
vim.keymap.set("n", "<Right>", "<Nop>", opts)
vim.keymap.set("n", "<Up>", "<Nop>", opts)
vim.keymap.set("n", "<Down>", "<Nop>", opts)
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts)
-- vim.keymap.set('n', 'q', '<Nop>', opts)
-- vim.keymap.set('n', 'Q', '<Nop>', opts)
vim.keymap.set("n", "<leader>gtc", ":e ~/.config/nvim/<CR>", opts)
vim.keymap.set("n", "<leader>bn", ":bn<CR>", opts)
vim.keymap.set("n", "<leader>bp", ":bp<CR>", opts)
vim.keymap.set("n", "<leader>x", ":bd<CR>", opts)
vim.keymap.set("n", "<leader>r;", ":RemoveAllSemicolons<CR>", opts)
vim.keymap.set("n", "<C-s>", function()
	local path = vim.fn.expand("%:p:h")
	local file_name = vim.fn.input("save to: ", path)
	vim.cmd(":w " .. file_name)
end)
-- vim.keymap.set("n", "vv", "<C-v>", opts)
-- vim.keymap.set("n", "<leader>i", "'I", opts)
-- vim.keymap.set("n", "<leader>o", "'O", opts)
-- vim.keymap.set("n", "<leader>p", "'P", opts)

vim.keymap.set("i", "<C-h>", "<esc>gUiw`]a", opts)
vim.keymap.set("i", "<C-l>", "<esc>guiw`]a", opts)
vim.keymap.set({ "i", "c" }, "<C-v>", "<C-r>+", opts)
vim.keymap.set("i", "<Left>", "<Nop>", opts)
vim.keymap.set("i", "<Right>", "<Nop>", opts)
vim.keymap.set("i", "<Up>", "<Nop>", opts)
vim.keymap.set("i", "<Down>", "<Nop>", opts)

-- Paste in visual mode without copying
vim.keymap.set("x", "p", "pgvy", opts)
vim.keymap.set("v", "<C-c>", '"+y', opts)

-- run the command that's selected in shell
-- vim.keymap.set("v", "<leader>rl", '"ty:!<C-r>t<CR>', opts)
-- run the command that's selected in shell
-- and read into the buffer
-- vim.keymap.set("v", "<leader>rL", '"ty:r!<C-r>t<CR>', opts)
-- run the command that's on the current line in shell
-- vim.keymap.set("n", "<leader>rl", '<S-v>"ty:!<C-r>t<CR>', opts)
-- run the command that's on the current line in shell
-- and read into the buffer
-- vim.keymap.set("n", "<leader>rL", '<S-v>"ty:r!<C-r>t<CR>', opts)

-- visual mode "autopairs"
vim.keymap.set("v", "'", "<esc>a'<esc>gvo<esc>i'<esc>", opts)
vim.keymap.set("v", '"', '<esc>a"<esc>gvo<esc>i"<esc>', opts)
vim.keymap.set("v", "(", "<esc>a)<esc>gvo<esc>i(<esc>", opts)
vim.keymap.set("v", "{", "<esc>a}<esc>gvo<esc>i{<esc>", opts)
vim.keymap.set("v", "[", "<esc>a]<esc>gvo<esc>i[<esc>", opts)

-- Plugins

-- NeoTree
vim.keymap.set("n", "<leader>n", ":Neotree reveal toggle<CR>", opts)
vim.keymap.set("n", "<leader>m", ":Neotree git_status toggle<CR>", opts)
-- vim.keymap.set("n", "<leader>b", ":Neotree buffers toggle<CR>", opts)
-- let NERDTreeShowHidden=1

-- Not Git fugitive
-- vim.keymap.set('n', '<leader>g', ':G<CR>', opts)
vim.keymap.set("n", "<leader>ga", ":!git add .<CR>", opts)
vim.keymap.set("n", "<leader>gc", ':!git commit -m ""<Left>', opts)
-- vim.keymap.set('n', '<leader>gb', ':G blame<CR>', opts)
vim.keymap.set("n", "<leader>gs", ":!git status<CR>", opts)
-- vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<CR>', opts)
vim.keymap.set("n", "<leader>gp", ":!git push origin ", opts)
-- prettier
-- vim.keymap.set("n", "<leader>pr", ":Format<cr>", opts)
vim.keymap.set("n", "<leader>pr", function()
	vim.lsp.buf.format()
end, opts)

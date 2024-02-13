P = function(v)
	print(vim.inspect(v))
	return v
end

LAZY_PLUGIN_SPEC = {}

function spec(item)
	table.insert(LAZY_PLUGIN_SPEC, { import = item })
end

-- example = function()
-- 	P(vim.api)
-- end

-- get_buf = function()
-- 	print(vim.api.nvim_get_current_buf())
-- end

-- p_buf = function(bufnr, values)
-- 	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, values)
-- end

-- vim.api.nvim_create_autocmd('BufWritePost', {
-- 	group = vim.api.nvim_create_augroup("test_group", {
-- 		clear = true,
-- 	}),
-- 	pattern = {'*.hui'},
-- 	callback = function(e)
-- 		-- P(e)
-- 		-- print(vim.bo.filetype)
-- 		vim.cmd('vsplit')
-- 		local win = vim.api.nvim_get_current_win()
-- 		local buf = vim.api.nvim_create_buf(true, true)
-- 		vim.api.nvim_win_set_buf(win, buf)
-- 		local append_data = function(data)
-- 			vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
-- 		end
-- 		vim.fn.jobstart({'ls', '-alh'}, {
-- 			stdout_buffered = true,
-- 			on_stdout = function(_, data)
-- 				if data then
-- 					append_data(data)
-- 				end
-- 			end,
-- 			on_stderr = function(_, data)
-- 				if data then
-- 					append_data(data)
-- 				end
-- 			end,
-- 		})
-- 	end,
-- })

-- vim.api.nvim_create_user_command('UserCommand', function()
-- 	print 'this is a user comand'
-- 	local text = vim.fn.input 'input some text here: '
-- 	local command = vim.fn.input 'input your command: '
-- 	local pattern = vim.fn.input 'input your pattern: '
-- 	print('here is your input: ', text)
-- end, {})

vim.api.nvim_create_user_command("RemoveAllSemicolons", function()
	pcall(vim.cmd, "%s/;//g")
	vim.cmd("noh")
end, {})

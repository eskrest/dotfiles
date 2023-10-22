local M = {}

M.setup = function()
	local loaded, cmp = pcall(require, 'cmp')

	if not loaded then
		return
	end

	cmp.setup({
		sources = {
			-- list of sources
			-- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
			{ name = "buffer" },
			{ name = "nvim_lua" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "luasnip" },
		},
		mapping = cmp.mapping.preset.insert({
			-- Enter key confirms completion item
			["<CR>"] = cmp.mapping.confirm({ select = false }),
			-- TODO
			-- read :help ins-completion
			["<Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end,
			["<S-Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end,
		}),
		snippet = {
			expand = function(args)
				local loaded, luasnip = pcall(require, 'luasnip')

				if not loaded then
					return
				end

				luasnip.lsp_expand(args.body)
			end,
		},
		experimental = {
			-- doesn't work
			-- native_menu = false,
			ghost_text = true,
		},
	})

	-- enable some sources on a file type
	-- vim.cmd [[
	-- 	autogroup DadbotSql
	-- 		au!
	-- 		autocmd FileType sql,mysql lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
	-- 	autogroup end
	-- ]]
	--
	--
	-- disable some sources on a file type
	-- autocmd FileType java lua require('cmp').setup.buffer { enabled = false }
end

return M

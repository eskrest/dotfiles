local M = {}

M.setup = function()
	local loaded, lspconfig = pcall(require, 'lspconfig')

	if not loaded then
		return
	end

	local lsp_defaults = lspconfig.util.default_config

	lsp_defaults.capabilities =
		vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

	lsp_defaults.on_attach = function(client, bufnr)
		local opts = { buffer = bufnr }

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)

		-- gd works like shit in vue files
		-- so I disable it there
		-- if vim.bo.filetype == "vue" then
		-- 	print("lsp definition disabled")
		-- else
		-- 	print("lsp definition disabled")
		-- 	-- vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
		-- end
		-- vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
		-- vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
		-- vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
		vim.keymap.set('n', '<leader>gd', function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "gr", function()
			vim.lsp.buf.references()
		end, opts)
		-- vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, opts)
		-- vim.keymap.set('n', '<F2>', function() vim.lsp.buf.rename() end, opts)
		-- vim.keymap.set('n', '<F3>', function() vim.lsp.buf.formatting() end, opts)
		-- vim.keymap.set('x', '<F3>', function() vim.lsp.buf.range_formatting() end, opts)
		-- vim.keymap.set('n', '<F4>', function() vim.lsp.buf.code_action() end, opts)

		-- vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end, opts)
		-- vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
		-- vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
	end

	local default_setup = function(server)
		lspconfig[server].setup({})
	end

	local loaded, mason = pcall(require, 'mason')

	if not loaded then
		return
	end

	mason.setup({})

	local loaded, masonLspconfig = pcall(require, 'mason-lspconfig')

	if not loaded then
		return
	end

	masonLspconfig.setup({
		ensure_installed = { "tsserver", "emmet_ls" },
		handlers = { default_setup },
	})

	lspconfig.tsserver.setup({})
	lspconfig.vuels.setup({})

	local configs = require("lspconfig/configs")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	lspconfig.emmet_ls.setup({
		-- on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "html", "javascriptreact", "vue", "php" },
		init_options = {
			html = {
				options = {
					-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
					-- ["bem.enabled"] = true,
				},
			},
		},
	})

	-- install insured formatters for mason
	local ensure_installed_formatters = {
		'prettier',
		'stylua',
	}

	local loaded, masonRegistry = pcall(require, 'mason-registry')
	if not loaded then
		return
	end

	local installed_packages = masonRegistry.get_installed_package_names()

	for _, item in pairs(ensure_installed_formatters) do
		local found = false
		for _, package in pairs(installed_packages) do
			if package == item then
				found = true
			end
		end
		if not found then
			pcall(vim.cmd, 'MasonInstall ' .. item)
		end
	end
end

return M

local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{
			"hrsh7th/cmp-nvim-lsp",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-buffer",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-path",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-cmdline",
			event = "InsertEnter",
		},
		{
			"saadparwaiz1/cmp_luasnip",
			event = "InsertEnter",
		},
		{
			"L3MON4D3/LuaSnip",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-nvim-lua",
		},
	},
}

function M.config()
	local loaded, cmp = pcall(require, "cmp")

	if not loaded then
		return
	end

	local loaded, luasnip = pcall(require, "luasnip")

	if not loaded then
		return
	end

	cmp.setup({
		sources = {
			{ name = "buffer" },
			{ name = "nvim_lua" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "luasnip" },
			{ name = "calc" },
			{ name = "cmp_tabnine" },
		},
		mapping = cmp.mapping.preset.insert({
			["<CR>"] = cmp.mapping.confirm({ select = false }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				-- elseif luasnip.expand_or_jumpable() then
				-- 	luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				-- elseif luasnip.jumpable(-1) then
				-- 	luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		snippet = {
			expand = function(args)
				local loaded, luasnip = pcall(require, "luasnip")

				if not loaded then
					return
				end

				luasnip.lsp_expand(args.body)
			end,
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			completion = {
				border = "rounded",
				scrollbar = false,
			},
			documentation = {
				border = "rounded",
			},
		},
		experimental = {
			ghost_text = true,
		},
	})
end

return M

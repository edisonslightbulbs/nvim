local cmp_status, cmp = pcall(require, 'cmp')
if not cmp_status then
	print('-- something went wrong while setting cmp!')
	return
end

local lspkind_status, lspkind = pcall(require, 'lspkind')
if not lspkind_status then
	print('-- something went wrong while setting up lspkind!')
	return
end

local luasnip_status, luasnip = pcall(require, 'luasnip')
if not luasnip_status then
	print('-- something went wrong while setting up luasnip!')
	return
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<C-j>'] = cmp.mapping.scroll_docs(-1),
		['<C-Space>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = cmp.config.sources({
		{ name = 'luasnip' },
		{ name = 'path', keyword_length = 3 },
		{ name = 'nvim_lsp', keyword_length = 5 },
		{ name = 'nvim_lua', keyword_length = 5 },
		{ name = 'buffer', keyword_length = 5 },
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol',
			menu = {
				luasnip = '[snipp]',
				path = '[path]',
				nvim_lsp = '[symbol]',
				nvim_lua = '[lua]',
				buffer = '[buff]',
			},
			symbol_map = {
				Text = '',
				Method = '',
				Function = '',
				Constructor = '',
				Field = 'ﰠ',
				Variable = '',
				Class = '',
				Interface = '',
				Module = '',
				Property = '',
				Unit = '塞',
				Value = '',
				Enum = '',
				Keyword = '',
				Snippet = '',
				Color = '',
				File = '',
				Reference = '',
				Folder = '',
				EnumMember = '',
				Constant = '',
				Struct = '﬘',
				Event = '',
				Operator = '',
				TypeParameter = '',
			},
		}),
	},
})

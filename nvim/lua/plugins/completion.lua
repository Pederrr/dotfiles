return {
	{
		'hrsh7th/nvim-cmp',
		lazy = false,
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-nvim-lsp-signature-help',

			-- snippets
			{
				'L3MON4D3/LuaSnip',
				build = 'make install_jsregexp',
			},
			'saadparwaiz1/cmp_luasnip',
			'rafamadriz/friendly-snippets',
		},
		config = function()
			local cmp = require 'cmp'

			require('luasnip.loaders.from_vscode').lazy_load()

			cmp.setup {
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end
				},
				mapping = cmp.mapping.preset.insert({
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<CR>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
				}),
				sources = {
					{ name = 'path' },
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'nvim_lsp_signature_help' },
					{ name = 'buffer' },
				},
			}
		end,
	}
}

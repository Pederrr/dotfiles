return {
	{
		'hrsh7th/nvim-cmp',
		lazy = false,
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lsp-signature-help'
		},
		config = function()
			local cmp = require 'cmp'

			cmp.setup {
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
					{ name = 'nvim_lsp_signature_help' },
				},
			}

			vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
		end,
	}
}

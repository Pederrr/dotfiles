return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		lazy = false,
		config = function()
			local treesitter = require('nvim-treesitter')

			local languages = {
				'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'vim', 'vimdoc', 'query', 'python'
			}
			treesitter.install(languages)

			-- allow highlighting for all filetypes that have a parser installed
			vim.api.nvim_create_autocmd('FileType', {
				pattern = languages,
				callback = function() vim.treesitter.start() end,
			})

			-- folding
			vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			vim.wo[0][0].foldmethod = 'expr'

			-- indentation
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	},
}

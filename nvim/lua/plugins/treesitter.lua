return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		lazy = false,
		config = function()
			local treesitter = require('nvim-treesitter')
			local languages = {
				'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'vim', 'vimdoc', 'query', 'python',
				'ruby', 'yaml', 'json',
			}
			treesitter.install(languages)

			-- allow highlighting for all filetypes that have a parser installed
			vim.api.nvim_create_autocmd('FileType', {
				pattern = languages,
				callback = function()
					vim.treesitter.start()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}

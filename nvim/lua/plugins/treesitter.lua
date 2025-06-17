return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		lazy = false,
		opts = {
			ensure_installed = {
				'bash',
				'c',
				'html',
				'lua',
				'luadoc',
				'markdown',
				'markdown_inline',
				'vim',
				'vimdoc',
				'query',
			},
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { 'ruby' },
			},
			indent = { enable = true, disable = { 'ruby' } },
			textobjects = {
				move = {
					enable = true,
					set_jumps = false,
					goto_next_start = {
						--- ... other keymaps
						[']c'] = { query = '@code_cell.inner', desc = 'next code block' },
					},
					goto_previous_start = {
						--- ... other keymaps
						['[c'] = { query = '@code_cell.inner', desc = 'previous code block' },
					},
				},
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						--- ... other keymaps
						['ic'] = { query = '@code_cell.inner', desc = 'in block' },
						['ac'] = { query = '@code_cell.outer', desc = 'around block' },
					},
				},
			},
		},
		config = function(_, opts)
			-- Prefer git instead of curl in order to improve connectivity in some environments
			require('nvim-treesitter.install').prefer_git = true
			---@diagnostic disable-next-line: missing-fields
			require('nvim-treesitter.configs').setup(opts)
		end,
	},
}

local function open_files()
	require('fzf-lua').files()
end

local function open_grep()
	require('fzf-lua').grep_project()
end

return {
	{
		'ibhagwan/fzf-lua',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {},
		config = function()
			vim.keymap.set('n', '<C-p>', open_files, {})
			vim.keymap.set('n', '<C-a>', open_grep, {})
		end,
	}
}

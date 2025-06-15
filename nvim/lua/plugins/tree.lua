local function toggle_tree()
	require('nvim-tree.api').tree.toggle()
end

return {
	{
		'nvim-tree/nvim-tree.lua',
		lazy = false,
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {},
		config = function()
			require('nvim-tree').setup()
			vim.keymap.set('n', 'tt', toggle_tree, { noremap = true, silent = true })
		end,
	}
}

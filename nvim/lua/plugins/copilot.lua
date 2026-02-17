return {
	{
		'zbirenbaum/copilot.lua',
		opts = {
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = '<C-CR>',
					accept_word = '<C-l>',
				},
			},
			filetypes = {
				yaml = true,
				markdown = true,
			},
		},
		-- enabled = false,
	},
}

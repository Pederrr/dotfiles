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
			copilot_model = 'gpt-4o-copilot',
			filetypes = {
				yaml = true,
				markdown = true,
			},
		},
		-- enabled = false,
	},
}

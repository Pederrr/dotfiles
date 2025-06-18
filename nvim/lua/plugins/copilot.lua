return {
	{
		'zbirenbaum/copilot.lua',
		opts = {
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = '<M-L>',
					accept_word = '<M-l>',
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

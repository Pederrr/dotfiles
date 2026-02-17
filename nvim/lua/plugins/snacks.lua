return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		dashboard = { enabled = true },
		picker = { enabled = true },
		indent = { enabled = true },
		notifier = { enabled = true },
		input = { enabled = true },
		image = { enabled = true },
		quickfiles = { enabled = true },
		statuscolumn = { enabled = true },
		scroll = { enabled = true },
	},
	keys = {
		-- Picker
		{ "<C-p>", function() Snacks.picker.files() end, desc = "File picker" },
		{ "<C-a>", function() Snacks.picker.grep() end,  desc = "Grep picker" },
	},

}

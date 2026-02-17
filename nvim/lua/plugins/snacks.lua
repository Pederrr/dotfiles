return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = { enabled = true },
	},
	keys = {
		-- Picker
		{ "<C-p>", function() Snacks.picker.files() end, desc = "File picker" },
		{ "<C-a>", function() Snacks.picker.grep() end,  desc = "Grep picker" },
	},

}

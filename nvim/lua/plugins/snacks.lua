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
		{ "<C-p>",      function() Snacks.picker.files() end,                 desc = "File picker" },
		{ "<C-a>",      function() Snacks.picker.grep() end,                  desc = "Grep picker" },

		-- LSP
		{ "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
		{ "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
		{ "gr",         function() Snacks.picker.lsp_references() end,        nowait = true,                  desc = "References" },
		{ "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
		{ "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
		{ "gai",        function() Snacks.picker.lsp_incoming_calls() end,    desc = "C[a]lls Incoming" },
		{ "gao",        function() Snacks.picker.lsp_outgoing_calls() end,    desc = "C[a]lls Outgoing" },
		{ "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
		{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
	},

}

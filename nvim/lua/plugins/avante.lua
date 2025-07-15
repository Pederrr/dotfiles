return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		---@module 'avante'
		---@type avante.Config
		opts = {
			-- add any opts here
			-- for example
			provider = "gemini",
			providers = {
				--copilot = {
				--model = "claude-3.7-sonnet"
				--},
				ollama = {
					enpoint = "http://localhost:11434",
					model = "deepseek-r1:1.5b", -- your desired model (or use gpt-4o, etc.)
				}
			}
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"hrsh7th/nvim-cmp",   -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua",   -- for file_selector provider fzf
			"stevearc/dressing.nvim", -- for input provider dressing
			"folke/snacks.nvim",  -- for input provider snacks
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			'MeanderingProgrammer/render-markdown.nvim',
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
		},
	}
}

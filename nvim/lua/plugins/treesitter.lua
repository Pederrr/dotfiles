return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		lazy = false,
		opts = {
			sync_install = false,
			ignore_install = {},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			}
		}
	}
}

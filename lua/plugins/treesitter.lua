return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		opts = {
			ensure_installed = {
				"javascript",
				"typescript",
				"html",
				"css",
				"glimmer",
				"lua",
			},
			highlight = {
				enable = true,
			},
		},
	},
}

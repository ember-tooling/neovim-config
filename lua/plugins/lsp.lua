return {
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = { "ember", "lua_ls", "ts_ls", "html", "cssls" },
			automatic_enable = true,
		},
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {},
			},
			{
				"saghen/blink.cmp",
				version = "0.*",
				dependencies = "rafamadriz/friendly-snippets",
				opts = {
					-- See :h blink-cmp-config-keymap for defining your own keymap
					keymap = { preset = "default" },
				},
				opts_extend = { "sources.default" },
			},
			{
				"neovim/nvim-lspconfig",
			},
		},
	},
}

return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = { "windwp/nvim-ts-autotag" },
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		treesitter.setup({
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"css",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"typescript",
				"tsx",
				"markdown",
				"markdown_inline",
				"lua",
				"luadoc",
				"luap",
				"regex",
				"yaml",
				"xml",
				"prisma",
				"vim",
				"vimdoc",
				"dockerfile",
				"gitignore",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}

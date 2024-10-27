return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		delay = function()
			return 1000
		end,
		icons = {
			rules = false,
			mappings = false,
			separator = "-",
		},
	},
}

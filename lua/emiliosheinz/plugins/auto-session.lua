return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = true,
			auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop/" },
			session_lens = {
				load_on_setup = true,
				theme_conf = { border = true },
				previewer = false,
				buftypes_to_ignore = {},
			},
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" })
		keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session for cwd" })
		keymap.set("n", "<leader>wl", "<cmd>AutoSession search<CR>", { desc = "Search for saved session" })
	end,
}

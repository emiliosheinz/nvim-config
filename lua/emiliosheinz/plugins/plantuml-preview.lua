return {
	"weirongxu/plantuml-previewer.vim",
	dependencies = { "tyru/open-browser.vim" },
	config = function()
		vim.keymap.set("n", "<leader>pp", vim.cmd.PlantumlOpen, { desc = "Preview Plantuml" })
	end,
}

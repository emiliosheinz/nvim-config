return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = ":call mkdp#util#install()",
	config = function()
		vim.g.mkdp_auto_close = 0
		vim.keymap.set("n", "<leader>pm", vim.cmd.MarkdownPreviewToggle, { desc = "Preview Markdown" })
	end,
}

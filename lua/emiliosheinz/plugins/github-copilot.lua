return {
	{
		"github/copilot.vim",
		init = function()
			vim.g.copilot_no_tab_map = true
		end,
		config = function()
			vim.keymap.set("i", "<C-a>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})
			vim.keymap.set("i", "<C-w>", "<Plug>(copilot-accept-word)")
			vim.keymap.set("i", "<C-e>", "<Plug>(copilot-accept-line)")
			vim.keymap.set("i", "<C-d>", "<Plug>(copilot-dismiss)")
			-- Disable copilot by default
			vim.cmd(":Copilot disable")
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		config = function()
			local chat = require("CopilotChat")
			local select = require("CopilotChat.select")
			local chat_actions = require("CopilotChat.actions")
			local chat_telescope = require("CopilotChat.integrations.telescope")

			require("CopilotChat.integrations.cmp").setup()

			chat.setup({
				window = {
					layout = "float",
					width = 0.8,
					height = 0.8,
					row = 2,
				},
				selection = function(source)
					return select.visual(source) or select.buffer(source)
				end,
			})

			vim.keymap.set(
				{ "n", "v" },
				"<leader>cco",
				":CopilotChatOpen<CR>",
				{ desc = "CopilotChat - Open chat window" }
			)

			vim.keymap.set({ "n", "v" }, "<leader>ccq", function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					chat.ask(input)
				end
			end, { desc = "CopilotChat - Quick chat" })

			vim.keymap.set({ "n", "v" }, "<leader>ccp", function()
				chat_telescope.pick(chat_actions.prompt_actions())
			end, { desc = "CopilotChat - Prompt action" })
		end,
	},
}

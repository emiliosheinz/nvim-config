return {
  {
    "github/copilot.vim",
    init = function()
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      vim.keymap.set("i", "<C-y>", 'copilot#Accept("\\<CR>")', {
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
    branch = "main",
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

      chat.setup({
        window = { width = 0.35 },
        selection = function(source)
          return select.visual(source) or select.buffer(source)
        end,
        prompts = {
          ExtractTranslationsSource = {
            prompt =
            'Please, give me a valid JSON where the key and value are the parameters being passed to the several lang function calls. E.g.: lang("parameter") should result in {"parameter": "parameter"}.',
          },
        },
        chat_autocomplete = true,
      })

      vim.keymap.set(
        { "n", "v" },
        "<leader>cco",
        ":CopilotChatOpen<CR>",
        { desc = "CopilotChat - Open chat window" }
      )

      vim.keymap.set({ "n", "v" }, "<leader>ccq", function()
        chat.reset() -- Reset the chat before opening
        chat.open() -- Open the chat
      end, { desc = "CopilotChat - New chat" })

      vim.keymap.set({ "n", "v" }, "<leader>ccp", function()
        chat_telescope.pick(chat_actions.prompt_actions())
      end, { desc = "CopilotChat - Prompt action" })
    end,
  },
}

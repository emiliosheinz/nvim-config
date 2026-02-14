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
}

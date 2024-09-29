return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_no_tab_map = true
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
}

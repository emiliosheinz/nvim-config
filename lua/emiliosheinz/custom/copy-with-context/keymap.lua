local copy_with_context = require("emiliosheinz.custom.copy-with-context")

vim.keymap.set("n", "<leader>yc", copy_with_context.copy_normal_mode, { desc = "Yank current line with context" })

vim.keymap.set("x", "<leader>yc", function()
  local mode = vim.fn.mode()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
  vim.schedule(function()
    if mode == "V" then
      copy_with_context.copy_visual_line_mode()
    else
      copy_with_context.copy_visual_mode()
    end
  end)
end, { desc = "Yank selection with context" })

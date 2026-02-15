return {
  dir = vim.fn.stdpath("config") .. "/lua/emiliosheinz/custom/copy-with-context",
  name = "copy-with-context",
  keys = {
    { "<leader>yc", mode = "n", desc = "Yank current line with context" },
    { "<leader>yc", mode = "v", desc = "Yank selection with context" },
  },
  config = function()
    require("emiliosheinz.custom.copy-with-context").setup()
  end,
}

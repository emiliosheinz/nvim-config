return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvimtools/none-ls-extras.nvim" },
  requires = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      root_dir = require("null-ls.utils").root_pattern(".git", "package.json"),
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.biome.with({ only_local = "node_modules/.bin" }),
        null_ls.builtins.formatting.prettier.with({ only_local = "node_modules/.bin" }),
        require("none-ls.diagnostics.eslint").with({ only_local = "node_modules/.bin" }),
        require("none-ls.formatting.eslint").with({ only_local = "node_modules/.bin" }),
      },
      -- Configures autoformatting on save
      -- on_attach = function(_, bufnr)
      --   vim.api.nvim_create_autocmd("BufWritePre", {
      --     group = augroup,
      --     buffer = bufnr,
      --     callback = function()
      --       vim.lsp.buf.format()
      --     end,
      --   })
      -- end,
    })

    vim.keymap.set({ "n", "v" }, "<leader>gf", vim.lsp.buf.format, { desc = "Format file or selection" })
  end,
}

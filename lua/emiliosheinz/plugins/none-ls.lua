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
      -- 	vim.api.nvim_create_autocmd("BufWritePre", {
      -- 		group = augroup,
      -- 		buffer = bufnr,
      -- 		callback = function()
      -- 			vim.lsp.buf.format()
      -- 		end,
      -- 	})
      -- end,
    })

    vim.keymap.set({ "n", "v" }, "ff", function()
      local last_line = vim.fn.line("$")
      local last_column = vim.fn.col({ last_line, "$" }) - 1
      vim.lsp.buf.format({
        range = {
          -- Format from first to the last line of the the buffer for better performance
          -- On visual mode it is automatically set to the visual selection
          -- For some reason lines are 1 indexed and columns 0 🧐
          -- See: https://neovim.io/doc/user/lsp.html#vim.lsp.buf.format()
          ["start"] = { 1, 0 },
          ["end"] = { last_line, last_column },
        },
      })
    end, { desc = "Format file or selection", silent = true })
  end,
}

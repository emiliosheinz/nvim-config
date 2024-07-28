return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvimtools/none-ls-extras.nvim" },
  requires = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.completion.spell,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd.with({
					condition = function(utils)
						-- Only activate prettier when the project supports prettier
						-- https://prettier.io/docs/en/configuration.html
						return utils.has_file({
							".prettierrc",
							".prettierrc.json",
							".prettierrc.yml",
							".prettierrc.yaml",
							"prettierrc.json5",
							".prettierrc.js",
							"prettier.config.js",
							".prettierrc.mjs",
							"prettier.config.mjs",
							".prettierrc.cjs",
							"prettier.config.cjs",
							".prettierrc.toml",
						})
					end,
				}),
				require("none-ls.diagnostics.eslint_d"),
				require("none-ls.formatting.eslint_d"),
			},
			-- Configures autoformatting on save
			on_attach = function(_, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format()
					end,
				})
			end,
		})

    vim.keymap.set({ "n", "v" }, "<leader>gf", vim.lsp.buf.format, { desc = "Format file" })
  end,
}

local is_prettier_supported = function(utils)
	local has_prettier_config_file = function()
		return utils.root_has_file({
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
	end
	local has_prettier_config_in_package_json = function()
		if not utils.root_has_file("package.json") then
			return false
		end

		local root_dir = require("null-ls.utils").get_root()
		local package_json_path = root_dir .. "/" .. "package.json"
		local package_json = vim.fn.json_decode(vim.fn.readfile(package_json_path))
		return package_json and package_json.prettier
	end

	return has_prettier_config_file() or has_prettier_config_in_package_json()
end

local is_eslint_supported = function(utils)
	local has_eslint_config_file = function()
		return utils.root_has_file({
			-- v9,
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",
			"eslint.config.ts",
			"eslint.config.mts",
			"eslint.config.cts",
			-- v8
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.yaml",
			".eslintrc.yml",
			".eslintrc.json",
		})
	end
	local has_eslint_config_in_package_json = function()
		if not utils.root_has_file("package.json") then
			return false
		end

		local root_dir = require("null-ls.utils").get_root()
		local package_json_path = root_dir .. "/" .. "package.json"
		local package_json = vim.fn.json_decode(vim.fn.readfile(package_json_path))
		return package_json and package_json.eslintConfig
	end

	return has_eslint_config_file() or has_eslint_config_in_package_json()
end

local is_biome_supported = function(utils)
	local has_biome_config_file = function()
		return utils.root_has_file({
			"biome.json",
		})
	end

	return has_biome_config_file()
end

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
				null_ls.builtins.formatting.biome.with({ condition = is_biome_supported }),
				null_ls.builtins.formatting.prettierd.with({ condition = is_prettier_supported }),
				require("none-ls.diagnostics.eslint_d").with({ condition = is_eslint_supported }),
				require("none-ls.formatting.eslint_d").with({ condition = is_eslint_supported }),
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

		vim.keymap.set({ "n", "v" }, "<leader>gf", vim.lsp.buf.format, { desc = "Format file or selection" })
	end,
}

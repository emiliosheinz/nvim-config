local is_prettier_supported = function()
	local utils = require("null-ls.utils")
	local has_prettier_config_file = function()
		return utils.root_pattern(
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
			".prettierrc.toml"
		)(vim.api.nvim_buf_get_name(0)) ~= nil
	end

	local has_eslint_config_in_package_json = function()
		local root_dir = utils.root_pattern("package.json")(vim.api.nvim_buf_get_name(0))
		if not root_dir then
			return false
		end
		local package_json_path = root_dir .. "/" .. "package.json"
		local package_json = vim.fn.json_decode(vim.fn.readfile(package_json_path))
		return package_json and package_json.eslintConfig
	end

	return has_prettier_config_file() or has_eslint_config_in_package_json()
end

local is_eslint_supported = function()
	local utils = require("null-ls.utils")
	local has_eslint_config_file = function()
		return utils.root_pattern(
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
			".eslintrc.json"
		)(vim.api.nvim_buf_get_name(0)) ~= nil
	end

	local has_eslint_config_in_package_json = function()
		local root_dir = utils.root_pattern("package.json")(vim.api.nvim_buf_get_name(0))
		if not root_dir then
			return false
		end
		local package_json_path = root_dir .. "/" .. "package.json"
		local package_json = vim.fn.json_decode(vim.fn.readfile(package_json_path))
		return package_json and package_json.eslintConfig
	end

	return has_eslint_config_file() or has_eslint_config_in_package_json()
end

local is_biome_supported = function()
	local utils = require("null-ls.utils")

	local has_biome_config_file = function()
		return utils.root_pattern("biome.json")(vim.api.nvim_buf_get_name(0)) ~= nil
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
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.biome.with({
					prefer_local = "node_modules/.bin",
					condition = is_biome_supported,
				}),
				null_ls.builtins.formatting.prettier.with({
					prefer_local = "node_modules/.bin",
					condition = is_prettier_supported,
				}),
				require("none-ls.diagnostics.eslint").with({
					prefer_local = "node_modules/.bin",
					condition = is_eslint_supported,
				}),
				require("none-ls.formatting.eslint").with({
					prefer_local = "node_modules/.bin",
					condition = is_eslint_supported,
				}),
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

		vim.keymap.set({ "n", "v" }, "<leader>=", function()
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

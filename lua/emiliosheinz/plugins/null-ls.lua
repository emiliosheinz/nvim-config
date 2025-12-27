-- Some documentation around Linters and Formatters
-- 'cause I'll probably forget that in the near future
--
-- Eslint and Biome are fully functional when installed through Mason.
-- Even though Prettier also can be installed that way, the formatting
-- is not triggered when vim.lsp.buf.format() is called. That is why
-- we have to register it using null-ls.
-- TODO: Possibly it would be better to migrate this entire thing to nvim-lint + conform

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
  local has_prettier_config_in_package_json = function()
    local root_dir = utils.root_pattern("package.json")(vim.api.nvim_buf_get_name(0))
    if not root_dir then
      return false
    end
    local package_json_path = root_dir .. "/" .. "package.json"
    local package_json = vim.fn.json_decode(vim.fn.readfile(package_json_path))
    return package_json and package_json.prettier
  end
  return has_prettier_config_file() or has_prettier_config_in_package_json()
end

return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvimtools/none-ls-extras.nvim" },
  requires = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier.with({
          prefer_local = "node_modules/.bin",
          condition = is_prettier_supported,
        }),
      },
    })
  end,
}

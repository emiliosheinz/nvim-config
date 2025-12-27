return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      -- available LSP servers: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
      require("mason-lspconfig").setup({
        ensure_installed = {
          "html",
          "cssls",
          "lua_ls",
          "ts_ls",
          "tailwindcss",
          "intelephense"
        },
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "biome",
          "eslint",
          "prettier",
          "js-debug-adapter",
          "stylua"
        },
      })
    end,
  },
}

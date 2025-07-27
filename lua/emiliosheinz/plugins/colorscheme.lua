return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = { 
          mason = true,
        },
        transparent_background = true,
        custom_highlights = function(colors)
          return {
            NormalFloat = { bg = colors.base, fg = colors.text },
          }
        end,
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}

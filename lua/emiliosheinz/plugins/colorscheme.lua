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
            TelescopeNormal = { bg = colors.base, fg = colors.text },
            TelescopeSelection = { bg = colors.surface0 },
          }
        end,
        color_overrides = {
          mocha = {
            base = "#181825"
          }
        }
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}

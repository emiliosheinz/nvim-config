return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = 'float',
      float_opts = {
        border = 'curved',
        width = function()
          return vim.o.columns
        end,
        height = function()
          -- Subtract cmdheight and 2 additional line to prevent border cutoff
          return vim.o.lines - vim.o.cmdheight - 2
        end,
      },
    })


    local Terminal = require('toggleterm.terminal').Terminal

    local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true })
    local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true })

    function ToggleLazyGit()
      lazygit:toggle()
    end

    function ToggleLazyDocker()
      lazydocker:toggle()
    end

    vim.keymap.set({ "v", "n" }, "<leader>lg", "<cmd>lua ToggleLazyGit()<CR>", { noremap = true, silent = true })
    vim.keymap.set({ "v", "n" }, "<leader>ld", "<cmd>lua ToggleLazyDocker()<CR>", { noremap = true, silent = true })
  end,
}

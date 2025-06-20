return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    local screen_w = vim.opt.columns:get()
    local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
    local window_h = screen_h * 0.96
    local window_w_int = math.floor(screen_w)
    local window_h_int = math.floor(window_h)

    require("toggleterm").setup({
      direction = 'float',
      float_opts = {
        border =  'curved',
        width = window_w_int,
        height = window_h_int,
        row = 0,
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

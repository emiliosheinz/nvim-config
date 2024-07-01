vim.cmd("let g:netrw_liststyle = 3")

-- line number
vim.opt.nu = true
vim.opt.relativenumber = true

-- tabs & indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.backspace = "indent,eol,start"

-- line wrapping
vim.opt.wrap = false

-- undo tree config
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- search settings
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- appearence
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.background = "dark"
vim.opt.cursorline = true -- highlight the current cursor line

-- split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- clipboard
vim.opt.clipboard:append("unnamedplus")

vim.opt.updatetime = 50

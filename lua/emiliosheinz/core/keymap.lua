vim.g.mapleader = " "
vim.keymap.set("n", "Q", "<nop>", { desc = "Avoid bad stuff to happen :)" })

-- formatting
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line up" })
vim.keymap.set("v", "L", ">gv", { desc = "Indent selected lines right" })
vim.keymap.set("v", "H", "<gv", { desc = "Indent selected lines left" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Delete line break" })
vim.keymap.set("n", "<Enter>", "o<ESC>", { desc = "Insert new line below" })
vim.keymap.set("n", "<S-Enter>", "O<ESC>", { desc = "Insert new line above" })
vim.keymap.set({ "n", "v" }, "=", function()
  vim.lsp.buf.format()
  -- Escape to exit visual mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
end, { desc = "Format selected text", silent = true })

-- native improvements
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Go half page DOWN while keeping cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Go half page UP while keeping cursor centered" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Keep cursor centered while searching next" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Keep cursor centered while searching previous" })

-- utils
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete into the void register" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Preserved data in the buffer when replacing" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current buffer executable" })

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
vim.keymap.set("n", "<leader>so", "<cmd>only<CR>", { desc = "Close all splits except current" })
vim.keymap.set("n", "<C-,>", "<C-w>10<", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-.>", "<C-w>10>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-/>", "<C-w>5-", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-;>", "<C-w>5+", { desc = "Increase window height" })
vim.keymap.set("n", "<leader>H", "<C-w>H", { desc = "Move to the left window" })
vim.keymap.set("n", "<leader>J", "<C-w>J", { desc = "Move to the bottom window" })

vim.keymap.set("n", "<leader>K", "<C-w>K", { desc = "Move to the top window" })
vim.keymap.set("n", "<leader>L", "<C-w>L", { desc = "Move to the right window" })

-- greatest remap ever
vim.keymap.set("v", "<leader>p", [["_dP]], { desc = "Preserved data in the buffer when replacing" })

-- qflist navigation
vim.keymap.set("n", "<leader>qn", ":cnext<CR>", { desc = "Go to next quickfix item" })
vim.keymap.set("n", "<leader>qp", ":cprev<CR>", { desc = "Go to previous quickfix item" })
vim.keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix list" })

-- allow navigation in insert mode
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move cursor left in insert mode" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move cursor down in insert mode" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move cursor up in insert mode" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move cursor right in insert mode" })

-- C-f starts tmux sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Remap add and subtract to a more convenient thing
vim.keymap.set("n", "+", "<C-a>", { desc = "Add number under cursor" })
vim.keymap.set("n", "-", "<C-x>", { desc = "Subtract number under cursor" })

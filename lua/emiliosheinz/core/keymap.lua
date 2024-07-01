vim.g.mapleader = " "
vim.keymap.set("n", "Q", "<nop>", { desc = "Avoid bad stuff to happen :)" })

-- formatting
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Delete line break" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format file" })

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

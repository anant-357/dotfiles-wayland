vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to left split" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to right split" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to lower split" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to upper split" })

vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)
vim.keymap.set("n", "<leader>vex", vim.cmd.Vex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv'")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv'")

-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })


vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left split' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right split' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower split' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper split' })

vim.keymap.set('n','K', '<cmd>lua vim.lsp.buf.hover()<cr>')

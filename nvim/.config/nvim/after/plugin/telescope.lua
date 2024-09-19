local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files'})
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope find git files'})
vim.keymap.set('n', '<leader>fp', builtin.live_grep, { desc = 'Telescope find phrase'})

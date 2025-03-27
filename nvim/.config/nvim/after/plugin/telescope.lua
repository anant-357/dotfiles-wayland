local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope [s]earch [f]iles' })
vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = 'Telescope [s]earch [g]it files' })
vim.keymap.set('n', '<leader>sp', builtin.live_grep, { desc = 'Telescope [s]earch [p]hrase' })

vim.keymap.set('n', '<leader>/', function() builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, }) end)



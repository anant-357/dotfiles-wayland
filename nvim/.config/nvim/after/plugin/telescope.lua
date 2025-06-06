local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope [s]earch [f]iles' })
vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = 'Telescope [s]earch [g]it files' })
vim.keymap.set('n', '<leader>sp', builtin.live_grep, { desc = 'Telescope [s]earch [p]hrase' })

vim.keymap.set('n', '<leader>/',
    function() builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, }) end)

vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, { desc = 'Telescope [g]oto [d]efinition' })
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = 'Telescope [g]oto [r]eferences' })
vim.keymap.set('n', '<leader>gI', builtin.lsp_implementations, { desc = 'Telescope [g]oto [I]mplementations' })

vim.keymap.set('n', '<leader>D', builtin.lsp_type_definitions, { desc = 'Telescope Type [D]efinition' });
vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, { desc = 'Telescope [d]ocument [s]ymbols' });
vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, { desc = 'Telescope [w]orkspace [s]ymbols' })

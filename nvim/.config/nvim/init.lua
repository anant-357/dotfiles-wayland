require('config.lazy')
require('config.keymaps')
require('config.settings')

if vim.g.neovide then 
    require('config.neovide')
end


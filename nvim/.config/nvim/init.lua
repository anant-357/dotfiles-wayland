require('config.lazy')

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

require("mason").setup()

require("lspconfig").rust_analyzer.setup {
}

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250

vim.opt.colorcolumn = "80"

vim.g.netrw_banner = 0

vim.g.have_nerd_font = false
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.o.completeopt = "menu,noinsert,popup,fuzzy"
vim.diagnostic.config { virtual_lines = true, virtual_text = { current_line = true } }

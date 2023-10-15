local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({


    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',

    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    'declancm/cinnamon.nvim',

    'nvim-treesitter/nvim-treesitter',

    'onsails/lspkind.nvim',
    'simrat39/rust-tools.nvim',

    "folke/which-key.nvim",

  { "dracula/vim", name="dracula", priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "morhetz/gruvbox", name = "gruvbox", url = "https://github.com/morhetz/gruvbox.git", priority = 1000 },
  { "fxn/vim-monochrome", name = "monochrome", priority = 1000 },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
theme = 'gruvbox',
	component_separators = { left = '', right = ''},
    	section_separators = { left = '', right = ''},
      },
    },
  },

}, {})



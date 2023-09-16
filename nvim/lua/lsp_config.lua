local cmp = require 'cmp'
local lspkind = require('lspkind')

cmp.setup {
  snippet = {
    expand = function(args)
	vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', 
      maxwidth = 50, 
      ellipsis_char = '...', 

      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
   sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help'},     
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'vsnip' },  
    { name = 'calc'},                    
  },
}

require('rust-tools').setup({
server = {
    settings = {
      ['rust-analyzer'] = {
        cargo = {
	  features = "all",
          autoReload = true
        }
      }
    }
  }
})

require("neoconf").setup({})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local servers = { "clangd", "rust_analyzer", "lua_ls", "tinymist", "nushell" }

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        capabilities = capabilities,
    })
end

require("mason").setup({})
require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({})
        end,
    },
})

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    }),
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
})

-- LSP Diagnostics Options Setup
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = "",
    })
end

sign({ name = "DiagnosticSignError", text = "󰅚" })
sign({ name = "DiagnosticSignWarn", text = "" })
sign({ name = "DiagnosticSignHint", text = "󰌶" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

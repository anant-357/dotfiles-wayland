vim.lsp.config.luals = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                diagnostics = { globals = { 'vim' } },
                workspace = {
                    library = {
                        vim.fn.expand("$VIMRUNTIME/lua"),
                        vim.fn.expand("$VIMRUNTIME/lua/vim"),
                    },
                    checkThirdParty = false, -- Avoids "third-party library" warning
                },
            }
        }
    }
}


vim.lsp.config.rust_analyzer = {
    cmd          = { "rust-analyzer" },
    filetypes    = { "rust" },
    root_markers = { "Cargo.toml" },
    settings     = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
        },
    },
}

vim.lsp.enable({ 'luals', 'rust_analyzer' })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(e)
        local client = vim.lsp.get_client_by_id(e.data.client_id)
        client.server_capabilities.completionProvider.triggerCharacters = vim.split("qwertyuiopasdfghjklzxcvbnm. ", "")
        vim.api.nvim_create_autocmd({ 'TextChangedI' }, {
            buffer = e.buf,
            callback = function()
                vim.lsp.completion.get()
            end

        })

        vim.lsp.completion.enable(true, client.id, e.buf, { autotrigger = true })
    end
})

vim.keymap.del({ "i", "s" }, "<Tab>")
vim.keymap.del({ "i", "s" }, "<S-Tab>")

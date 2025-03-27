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

vim.lsp.enable({ 'luals', 'rust-analyzer' })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(e)
        local client = vim.lsp.get_client_by_id(e.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, e.buf, { autotrigger = true })
        end
    end
})

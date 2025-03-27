return {
    { "ellisonleao/gruvbox.nvim",         priority = 1000, config = true },
    --{ "catppuccin/nvim",                  name = "catppuccin", priority = 1000 },
    { "nvim-telescope/telescope.nvim",    tag = "0.1.8",   requires = { { "nvim-lua/plenary.nvim" } } },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    { "folke/neoconf.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "sbdchd/neoformat" },
    {
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        keys = {
            { '<leader>f', function()
                require('conform').format { async = true, lsp_format = 'fallback' }
            end },
            mode = '',
            desc = '[F]ormat Buffer',
        },
    },
    opts = {
        notify_on_error = true,
        format_on_save = function()
            local disable_filetypes = { c = true, cpp = true }
            local lsp_format_opt
            if disable_filetypes[vim.bo[bufnr].filetype] then
                lsp_format_opt = 'never'
            else
                lsp_format_opt = 'fallback'
            end
            return {
                timeout_ms = 500,
                lsp_format = lsp_format_opt,
            }
        end,
        formatters_by_ft = {
            lua = { 'stylua' },
        },
    },
    {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
},
}

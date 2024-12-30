return {
    { "ellisonleao/gruvbox.nvim",         priority = 1000, config = true },
    --{ "catppuccin/nvim",                  name = "catppuccin", priority = 1000 },
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "nvim-telescope/telescope.nvim",    tag = "0.1.8",   requires = { { "nvim-lua/plenary.nvim" } } },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            { "nushell/tree-sitter-nu", build = ":TSUpdate nu" },
        },
        build = ":TSUpdate",
    },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
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
    -- nu
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            -- setup treesitter with config
        end,
        dependencies = {
            -- NOTE: additional parser
            { "nushell/tree-sitter-nu", build = ":TSUpdate nu" },
        },
        build = ":TSUpdate",
    },
}

 return {
	 { "ellisonleao/gruvbox.nvim", priority=1000, config = true },
 	 { "neovim/nvim-lspconfig" },
	 { "williamboman/mason.nvim" },
	 { "williamboman/mason-lspconfig.nvim" },
     { "hrsh7th/nvim-cmp" },
     { "hrsh7th/cmp-nvim-lsp" },
	 { "nvim-telescope/telescope.nvim", tag = '0.1.8', requires = {{ "nvim-lua/plenary.nvim" }}},
	 { "nvim-treesitter/nvim-treesitter" },
	 { "VonHeikemen/lsp-zero.nvim" , branch = 'v4.x'},
 }

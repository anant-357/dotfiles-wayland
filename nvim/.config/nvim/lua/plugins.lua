 return {
	 { "ellisonleao/gruvbox.nvim", priority=1000, config = true },
 	 { "neovim/nvim-lspconfig", dependencies = {
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	 },
	 config = function() 
		 require("lsp_lines").setup()
 		end
	 },
	 { "williamboman/mason.nvim" },
	 { "hrsh7th/nvim-cmp" },
 }

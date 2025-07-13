return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
			},
			mode = "",
			desc = "[F]ormat Buffer",
		},
		opts = {
			notify_on_error = true,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				rust = { "rustfmt", lsp_format = "fallback" },
				-- go = { "goimports", "gofmt" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = { timeout_ms = 500 },
		},
	},
}

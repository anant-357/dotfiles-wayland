return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.expand("$VIMRUNTIME/lua/vim"),
					},
					checkThirdParty = false, -- Avoids "third-party library" warning
				},
			},
		},
	},
}

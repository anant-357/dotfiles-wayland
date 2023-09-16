local ts_config = require('nvim-treesitter.configs')

ts_config.setup {
	ensure_installed = { 'rust', 'lua', 'vim'},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	}
}

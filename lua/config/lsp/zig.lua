return {
	setup = function(lspconfig, lsp)
		lspconfig.zls.setup({
			on_attach = function()
			end,
			cmd = { 'zls',
				"--enable-debug-log"
			},
			filetypes = { 'zig' },
		})
	end
}

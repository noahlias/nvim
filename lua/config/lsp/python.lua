return {
	setup = function(lspconfig, lsp)
		lspconfig.pyright.setup({
			on_attach = function()
			end,
			cmd = { 'delance-langserver', '--stdio' },
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
						inlayHints = {
							callArgumentNames = "partial",
							functionReturnTypes = true,
							pytestParameters = true,
							variableTypes = true,
						},
					},
				},
			},
		})
	end
}

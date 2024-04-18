return {
	setup = function(lspconfig, lsp)
		local capabilities = require('config.capabilities')
		lspconfig.gopls.setup({
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
			end,
			capabilities = capabilities,
			settings = {
				gopls = {
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
					gofumpt = true,
				},
			},
		})
	end
}

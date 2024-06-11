return {
  setup = function(lspconfig, _)
    local capabilities = require "config.capabilities"
    lspconfig.zls.setup {
      on_attach = function() end,
      cmd = { "zls" },
      filetypes = { "zig" },
      capabilities = capabilities,
    }
  end,
}

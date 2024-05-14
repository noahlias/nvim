return {
  setup = function(lspconfig, lsp)
    lspconfig.sqls.setup {
      on_attach = function(client, bufnr)
        require("sqls").on_attach(client, bufnr)
      end,
      -- NOTE: some new  <04/13, 2024, Noahlias> --
      -- settings = {
      -- 	sqls = {
      -- 		connections = {
      -- 			{
      -- 				driver = 'mysql',
      -- 				dataSourceName = 'root:root@tcp(127.0.0.1:13306)/world',
      -- 			},
      -- 			{
      -- 				driver = 'postgresql',
      -- 				dataSourceName =
      -- 				'host=127.0.0.1 port=15432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable',
      -- 			},
      -- 		},
      -- 	},
      -- },
    }
  end,
}

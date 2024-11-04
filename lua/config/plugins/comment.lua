--- @type LazyPluginSpec
return {
  "folke/ts-comments.nvim",
  opts = {
    lang = {
      c = "// %s",
      cpp = "// %s",
      zig = "// %s",
      css = "/* %s */",
      ql = "/* %s */",
      gleam = "// %s",
      http = "# %s",
      graphql = "# %s",
      hcl = "# %s",
      html = "<!-- %s -->",
      sql = "-- %s",
      svelte = "<!-- %s -->",
      lua = { "-- %s", "--- %s" }, -- langs can have multiple commentstrings
      terraform = "# %s",
      tsx = {
        "// %s", -- default commentstring when no treesitter node matches
        "/* %s */", -- will be used for uncommenting
        call_expression = "// %s",
        comment = "// %s",
        jsx_attribute = "// %s",
        jsx_element = "{/* %s */}",
        jsx_fragment = "{/* %s */}",
        spread_element = "// %s",
        statement_block = "// %s",
      },
      javascript = {
        "// %s",
        "/* %s */",
        call_expression = "// %s",
        jsx_attribute = "// %s",
        jsx_element = "{/* %s */}",
        jsx_fragment = "{/* %s */}",
        spread_element = "// %s",
        statement_block = "// %s",
      },
      python = { "# %s", '""" %s """', "''' %s '''" },
    },
  },
  event = "VeryLazy",
  enabled = vim.fn.has "nvim-0.10.0" == 1,
}

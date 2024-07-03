---@type LazyPluginSpec[]
return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        {
          path = "lazy.nvim",
          words = { "LazyPluginSpec", "LazyPluginConfig" },
        },
      },
      -- debug = true,
      enabled = function(root_dir)
        return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
      end,
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
}

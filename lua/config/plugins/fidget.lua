---@type LazyPluginSpec
return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  config = function()
    require("fidget").setup {
      ---NOTE: this is useful for the transparent background
      -- notification = {
      --   window = {
      --     winblend = 0,
      --   },
      -- },
    }
  end,
}

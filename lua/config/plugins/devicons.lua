---@type LazyPluginSpec
return {
  "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  config = function()
    require("nvim-web-devicons").setup {
      override_by_extension = {
        sh = {
          icon = "",
          color = "#89e051",
          cterm_color = "113",
          name = "Sh",
        },
        norg = {
          icon = "",
          color = "#97eefc",
          name = "Neorg",
        },
        ["typ"] = {
          icon = "𝐭",
          color = "#1a7682",
          cterm_color = "30",
          name = "Typst",
        },
      },
    }
  end,
}

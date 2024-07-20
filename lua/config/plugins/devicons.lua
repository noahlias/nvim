---@type LazyPluginSpec
return {
  "nvim-tree/nvim-web-devicons",
  event = { "BufNewFile", "BufReadPre" },
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
        ["gleam"] = {
          icon = "",
          color = "#ffaff3",
          cterm_color = "219",
          name = "Gleam",
        },
      },
    }
  end,
}

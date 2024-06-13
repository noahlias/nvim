---@type LazyPluginSpec
return {
  "pwntester/octo.nvim",
  cmd = { "Octo" },
  event = { { event = "BufReadCmd", pattern = "octo://*" } },
  opts = {
    enable_builtin = true,
    default_to_projects_v2 = true,
    default_merge_method = "squash",
    picker = "fzf-lua",
    picker_config = {
      use_emojis = true,
    },
  },
}

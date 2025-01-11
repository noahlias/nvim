---@type LazyPluginSpec
return {
  "pwntester/octo.nvim",
  cmd = { "Octo" },
  requires = {
    "nvim-lua/plenary.nvim",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
  },
  event = { { event = "BufReadCmd", pattern = "octo://*" } },
  opts = {
    enable_builtin = true,
    default_to_projects_v2 = true,
    default_merge_method = "squash",
    picker = "fzf-lua",
    picker_config = {
      use_emojis = true,
    },
    suppress_missing_scope = {
      projects_v2 = true,
    },
  },
}

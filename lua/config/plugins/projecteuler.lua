---@type LazyPluginSpec
return {
  "noahlias/projecteuler.nvim",
  cmd = {
    "ProjectEuler",
    "ProjectEulerCookie",
    "ProjectEulerCookieClear",
    "ProjectEulerCookieFromClipboard",
    "ProjectEulerProblem",
    "ProjectEulerRefresh",
    "ProjectEulerOpenBrowser",
    "ProjectEulerStats",
  },
  keys = {
    {
      "<leader>pe",
      function()
        require("projecteuler").open_picker()
      end,
      desc = "Project Euler",
    },
    {
      "<leader>ps",
      function()
        require("projecteuler").open_stats()
      end,
      desc = "Project Euler Stats",
    },
  },
  dependencies = { "ibhagwan/fzf-lua" },
  opts = {
    picker = "fzf-lua",
  },
  config = function(_, opts)
    require("projecteuler").setup(type(opts) == "table" and opts or {})
  end,
}

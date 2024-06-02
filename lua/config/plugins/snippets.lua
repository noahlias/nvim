return {
  {
    "SirVer/ultisnips",
    enabled = false,
    dependencies = {
      "honza/vim-snippets",
    },
    config = function()
      vim.g.UltiSnipsSnippetDirectories = { "~/.config/nvim/Ultisnips" }
    end,
  },
}

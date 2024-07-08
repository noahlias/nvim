---@type LazyPluginSpec
return {
  "AckslD/nvim-neoclip.lua",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    { "kkharji/sqlite.lua", module = "sqlite" },
  },
  config = function()
    ---TODO: change this to fzf-lua but telescope has more futures
    vim.keymap.set(
      "n",
      "<leader>y",
      ":Telescope neoclip<CR>",
      { noremap = true }
    )

    local function is_whitespace(line)
      return vim.fn.match(line, [[^\s*$]]) ~= -1
    end

    local function all(tbl, check)
      for _, entry in ipairs(tbl) do
        if not check(entry) then
          return false
        end
      end
      return true
    end
    require("neoclip").setup {
      history = 1000,
      enable_persistent_history = true,
      filter = function(data)
        return not all(data.event.regcontents, is_whitespace)
      end,
      keys = {
        telescope = {
          i = {
            select = "<c-y>",
            paste = "<cr>",
            paste_behind = "<c-g>",
            replay = "<c-q>", -- replay a macro
            delete = "<c-d>", -- delete an entry
            edit = "<c-k>", -- edit an entry
            custom = {},
          },
        },
      },
    }
  end,
}

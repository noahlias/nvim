---@type LazyPluginSpec
return {
  "AckslD/nvim-neoclip.lua",
  event = "VeryLazy",
  dependencies = {
    "ibhagwan/fzf-lua",
    { "kkharji/sqlite.lua", module = "sqlite" },
  },
  config = function()
    vim.keymap.set(
      "n",
      "<leader>my",
      ":lua require('neoclip.fzf')()<CR>",
      { noremap = true, desc = "Open Yank History", silent = true }
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
      -- TODO: Some bug with vimleavepre and sqlite causes a delay on exit
      enable_persistent_history = false,
      filter = function(data)
        return not all(data.event.regcontents, is_whitespace)
      end,
      keys = {
        fzf = {
          select = "default",
          paste = "ctrl-p",
          paste_behind = "ctrl-k",
          custom = {},
        },
      },
    }
  end,
}

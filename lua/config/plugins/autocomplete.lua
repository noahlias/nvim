local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api
        .nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match "%s"
      == nil
end
local limitStr = function(str)
  if #str > 25 then
    str = string.sub(str, 1, 22) .. "..."
  end
  return str
end

local M = {}
M.config = {
  "hrsh7th/nvim-cmp",
  -- after = "SirVer/ultisnips",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-calc",
    -- "andersevenrud/cmp-tmux",
    {
      "onsails/lspkind.nvim",
      lazy = false,
      config = function()
        require("lspkind").init()
      end,
    },
    -- {
    --   "quangnguyen30192/cmp-nvim-ultisnips",
    --   config = function()
    --     -- optional call to setup (see customization section)
    --     require("cmp_nvim_ultisnips").setup {}
    --   end,
    -- },
    {
      "garymjr/nvim-snippets",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
      opts = {
        friendly_snippets = true,
      },
    },
  },
}

local setCompHL = function()
  local fgdark = "#2E3440"

  vim.api.nvim_set_hl(
    0,
    "CmpItemAbbrMatch",
    { fg = "#82AAFF", bg = "NONE", bold = true }
  )
  vim.api.nvim_set_hl(
    0,
    "CmpItemAbbrMatchFuzzy",
    { fg = "#82AAFF", bg = "NONE", bold = true }
  )
  vim.api.nvim_set_hl(
    0,
    "CmpItemAbbrDeprecated",
    { fg = "#7E8294", bg = "NONE", strikethrough = true }
  )

  vim.api.nvim_set_hl(
    0,
    "CmpItemMenu",
    { fg = "#808080", bg = "NONE", italic = true }
  )
  vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = fgdark, bg = "#B5585F" })
  vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = fgdark, bg = "#B5585F" })
  vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = fgdark, bg = "#B5585F" })

  vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = fgdark, bg = "#9FBD73" })
  vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = fgdark, bg = "#9FBD73" })
  vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = fgdark, bg = "#9FBD73" })

  vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = fgdark, bg = "#D4BB6C" })
  vim.api.nvim_set_hl(
    0,
    "CmpItemKindConstructor",
    { fg = fgdark, bg = "#D4BB6C" }
  )
  vim.api.nvim_set_hl(
    0,
    "CmpItemKindReference",
    { fg = fgdark, bg = "#D4BB6C" }
  )

  vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = fgdark, bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = fgdark, bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = fgdark, bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = fgdark, bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = fgdark, bg = "#A377BF" })

  vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fgdark, bg = "#7E8294" })
  vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = fgdark, bg = "#7E8294" })

  vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = fgdark, bg = "#D4A959" })
  vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = fgdark, bg = "#D4A959" })
  vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = fgdark, bg = "#D4A959" })

  vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = fgdark, bg = "#6C8ED4" })
  vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = fgdark, bg = "#6C8ED4" })
  vim.api.nvim_set_hl(
    0,
    "CmpItemKindEnumMember",
    { fg = fgdark, bg = "#6C8ED4" }
  )

  vim.api.nvim_set_hl(
    0,
    "CmpItemKindInterface",
    { fg = fgdark, bg = "#58B5A8" }
  )
  vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = fgdark, bg = "#58B5A8" })
  vim.api.nvim_set_hl(
    0,
    "CmpItemKindTypeParameter",
    { fg = fgdark, bg = "#58B5A8" }
  )
end
local moveCursorBeforeComma = function()
  if vim.bo.filetype ~= "dart" then
    return
  end
  vim.defer_fn(function()
    local line = vim.api.nvim_get_current_line()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local char = line:sub(col - 2, col)
    if char == ": ," then
      vim.api.nvim_win_set_cursor(0, { row, col - 1 })
    end
  end, 100)
end

M.configfunc = function()
  local lspkind = require "lspkind"
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
  local cmp = require "cmp"
  -- local cmp_ultisnips_mappings = require "cmp_nvim_ultisnips.mappings"
  -- local luasnip = require("luasnip")

  setCompHL()
  cmp.setup {
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        -- luasnip.lsp_expand(args.body)
        -- vim.fn["UltiSnips#Anon"](args.body)
        -- NOTE: This has been injected by the nvim-snippets plugin not need to call it
        vim.snippet.expand(args.body)
      end,
    },
    enabled = function()
      ---@diagnostic disable-next-line: deprecated
      local buftype = vim.api.nvim_buf_get_option(0, "buftype")
      if buftype == "prompt" then
        return false
      end
      return true and vim.bo.ft ~= "norg" and vim.bo.ft ~= "tex"
    end,
    window = {
      completion = {
        -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        winblend = 0,
        border = "rounded",
        col_offset = -3,
        side_padding = 0,
      },
      documentation = cmp.config.window.bordered(),
    },
    sorting = {
      comparators = {
        -- label_comparator,
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.kind,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
      priority_weight = 2,
    },
    -- BUG: some bug
    experimental = {
      ghost_text = false,
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      maxwidth = 60,
      maxheight = 10,
      format = function(entry, vim_item)
        local kind = lspkind.cmp_format {
          mode = "symbol_text",
          symbol_map = { Codeium = "" },
        }(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. (strings[1] or "") .. " "
        -- HACK: Add some padding to the kind field
        local complete_item = limitStr(entry:get_completion_item().detail or "")
        local menu_table = {
          nvim_lsp = "LSP",
          snippets = "Snippet",
          -- ultisnips = "UltiSnips",
          buffer = "Buffer",
          path = "Path",
          nvim_lua = "Lua",
          calc = "Calc",
          crates = "Crates",
        }
        menu_table["vim-dadbod-completion"] = "SQL"
        local menu_kind = strings[2] or ""
        local menu_source = (menu_table[entry.source.name] or complete_item)
        local menu = menu_source .. "_" .. menu_kind
        if strings[2] == "Snippet" then
          menu = menu_source
        elseif entry.source.name == "nvim_lsp" then
          menu = menu_kind
        end
        kind.menu = menu
        return kind
      end,
      expandable_indicator = true,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      {
        name = "buffer",
        option = {
          get_bufnrs = function()
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              bufs[vim.api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(bufs)
          end,
        },
        { name = "nvim_lua" },
      },
      { name = "lazydev", group_index = 0 },
    }, {
      { name = "path" },
      { name = "snippets", keyword_length = 2 },
      { name = "calc" },
      { name = "crates" },
      { name = "vim-dadbod-completion" },
    }),
    mapping = cmp.mapping.preset.insert {
      ["<C-o>"] = cmp.mapping.complete(),
      ["<c-e>"] = cmp.mapping(function()
        -- cmp_ultisnips_mappings.compose { "expand", "jump_forwards" }(function() end)
        if vim.snippet.active { direction = 1 } then
          vim.schedule(function()
            vim.snippet.jump(1)
          end)
        end
      end, {
        "i",
        "s", --[[ "c" (to enable the mapping in command mode) ]]
      }),
      ["<c-n>"] = cmp.mapping(function()
        -- cmp_ultisnips_mappings.jump_backwards(fallback)
        if vim.snippet.active { direction = -1 } then
          vim.schedule(function()
            vim.snippet.jump(-1)
          end)
        end
      end, {
        "i",
        "s", --[[ "c" (to enable the mapping in command mode) ]]
      }),
      ["<c-f>"] = cmp.mapping {
        i = function(fallback)
          cmp.close()
          fallback()
        end,
      },
      ["<c-y>"] = cmp.mapping {
        i = function(fallback)
          fallback()
        end,
      },
      ["<CR>"] = cmp.mapping {
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
          else
            fallback()
          end
        end,
      },
      ["<Tab>"] = cmp.mapping {
        i = function(fallback)
          if cmp.visible() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
            moveCursorBeforeComma()
          elseif has_words_before() then
            cmp.complete()
            moveCursorBeforeComma()
          else
            fallback()
          end
        end,
      },
      ["<S-Tab>"] = cmp.mapping {
        i = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
            moveCursorBeforeComma()
          else
            fallback()
          end
        end,
      },
    },
  }
end

return M

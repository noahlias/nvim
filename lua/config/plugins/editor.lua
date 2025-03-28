vim.cmd [[
fun! s:MakePair()
	let line = getline('.')
	let len = strlen(line)
	if line[len - 1] == ";" || line[len - 1] == ","
		normal! lx$P
	else
		normal! lx$p
	endif
endfun
inoremap <c-u> <ESC>:call <SID>MakePair()<CR>
]]

---@type LazyPluginSpec[]
return {
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      local illuminate = require "illuminate"
      illuminate.configure {
        providers = {
          -- "lsp",
          -- "treesitter",
          "regex",
        },
        large_file_cutoff = 10000,
        should_enable = function(bufnr)
          local win = vim.fn.bufwinid(bufnr)
          local filetype = vim.bo[bufnr].filetype
          -- Very bad performance in diff-mode
          -- NOTE: disable illuminate in alpha buffer
          if win == -1 or filetype == "alpha" or (win and vim.wo[win].diff) then
            return false
          end
          return true
        end,
      }
      vim.api.nvim_create_autocmd("TextYankPost", {
        group = vim.api.nvim_create_augroup("highlight_on_yank", {}),
        desc = "Briefly highlight yanked text",
        callback = function()
          illuminate.pause()
          vim.highlight.on_yank()
          illuminate.resume()
        end,
      })
    end,
  },
  {
    "dkarter/bullets.vim",
    event = "VeryLazy",
    ft = { "markdown", "txt" },
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue or blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "virtualtext", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true,
        sass = { enable = false },
        virtualtext = "■",
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    },
  },
  { "theniceboy/antovim", event = "VeryLazy" },
  { "gcmt/wildfire.vim", event = "VeryLazy" },
  {
    "gbprod/substitute.nvim",
    event = "VeryLazy",
    config = function()
      local substitute = require "substitute"
      substitute.setup {
        highlight_substituted_text = {
          enabled = true,
          timer = 200,
        },
      }
      vim.keymap.set(
        "n",
        "st",
        substitute.operator,
        { noremap = true, desc = "substitute with motion" }
      )
      vim.keymap.set("n", "sh", function()
        substitute.operator { motion = "e" }
      end, { noremap = true })
      vim.keymap.set(
        "x",
        "s",
        require("substitute.range").visual,
        { noremap = true }
      )
      vim.keymap.set(
        "n",
        "ss",
        substitute.line,
        { noremap = true, desc = "substitute with line" }
      )
      vim.keymap.set("n", "sI", substitute.eol, { noremap = true })
      vim.keymap.set(
        "x",
        "s",
        substitute.visual,
        { noremap = true, desc = "substitute with visual" }
      )
      vim.keymap.set(
        "n",
        "sx",
        require("substitute.exchange").operator,
        { noremap = true, desc = "exchange with motion" }
      )
      vim.keymap.set(
        "x",
        "X",
        require("substitute.exchange").visual,
        { noremap = true }
      )
      vim.keymap.set(
        "n",
        "sxc",
        require("substitute.exchange").cancel,
        { noremap = true, desc = "cancel exchange with motion" }
      )

      -- NOTE: This is the same to move line up and down
      ---NOTE: I use the mini.move to change position
      -- vim.keymap.set("n", "sxx", require("substitute.exchange").line, { noremap = true, desc = "exchange with line" })
    end,
  },
  {
    --- NOTE: https://github.com/kevinhwang91/nvim-ufo/issues/4
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "VeryLazy",
    opts = {
      -- close_fold_kinds_for_ft = {
      --   default = { "imports" },
      -- },
    },
    init = function()
      local set_foldcolumn_for_file =
        vim.api.nvim_create_augroup("set_foldcolumn_for_file", {
          clear = true,
        })
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        group = set_foldcolumn_for_file,
        callback = function()
          if vim.bo.buftype == "" then
            vim.wo.foldcolumn = "1"
          else
            vim.wo.foldcolumn = "0"
          end
        end,
      })
      vim.api.nvim_create_autocmd("OptionSet", {
        group = set_foldcolumn_for_file,
        pattern = "buftype",
        callback = function()
          if vim.bo.buftype == "" then
            vim.wo.foldcolumn = "1"
          else
            vim.wo.foldcolumn = "0"
          end
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "copilot-chat" },
        callback = function()
          require("ufo").detach()
          vim.opt_local.foldenable = false
          vim.opt_local.foldcolumn = "0"
        end,
      })
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function(_, opts)
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local totalLines = vim.api.nvim_buf_line_count(0)
        local foldedLines = endLnum - lnum
        local suffix = ("  %d %d%%"):format(
          foldedLines,
          foldedLines / totalLines * 100
        )
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        local rAlignAppndx = math.max(
          math.min(vim.api.nvim_win_get_width(0), width - 1)
            - curWidth
            - sufWidth,
          0
        )
        suffix = (" "):rep(rAlignAppndx) .. suffix
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
      opts["fold_virt_text_handler"] = handler
      local ufo = require "ufo"
      ufo.setup(opts)

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Setup Ufo  with LSP hover",
        callback = function(args)
          local bufnr = args.buf
          vim.keymap.set("n", "<leader>lh", function()
            local winid = ufo.peekFoldedLinesUnderCursor()
            if not winid then
              vim.lsp.buf.hover()
            end
          end, { buffer = bufnr, desc = "LSP: Signature help" })
        end,
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    dependencies = {
      {
        "junegunn/fzf",
        build = function()
          vim.fn["fzf#install"]()
        end,
      },
    },
    opts = {
      auto_resize_height = true,
      preview = {
        border = "rounded",
        winblend = 0,
      },
    },
  },
  {
    "luukvbaal/statuscol.nvim",
    event = { "BufNewFile", "BufReadPre" },
    opts = function()
      ---NOTE: https://github.com/ofseed/nvim/blob/1abfedd821c313eae7e04558ecbd08a1953b055f/lua/plugins/ui/statuscol.lua#L4
      local builtin = require "statuscol.builtin"
      return {
        bt_ignore = { "nofile", "terminal" },
        ft_ignore = { "NeogitStatus" },
        segments = {
          {
            sign = {
              name = { ".*" },
              text = { ".*" },
            },
            click = "v:lua.ScSa",
          },
          {
            text = { builtin.lnumfunc },
            condition = { builtin.not_empty },
            click = "v:lua.ScLa",
          },
          {
            sign = { namespace = { "gitsigns" }, colwidth = 1, wrap = true },
            click = "v:lua.ScSa",
          },
          {
            text = {
              function(args)
                args.fold.close = ""
                args.fold.open = ""
                args.fold.sep = " "
                -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
                return builtin.foldfunc(args)
              end,
            },
            condition = {
              function()
                return vim.o.foldcolumn ~= "0"
              end,
            },
            click = "v:lua.ScFa",
          },
        },
      }
    end,
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
}

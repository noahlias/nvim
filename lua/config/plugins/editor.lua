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

return {
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      local illuminate = require "illuminate"
      illuminate.configure {
        providers = {
          -- 'lsp',
          -- 'treesitter',
          "regex",
        },
        large_file_cutoff = 10000,
        should_enable = function(bufnr)
          local win = vim.fn.bufwinid(bufnr)
          -- Very bad performance in diff-mode
          if vim.wo[win].diff then
            return false
          end
          return true
        end,
      }
      vim.cmd "hi IlluminatedWordText guibg=#393E4D gui=none"
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
    lazy = false,
    ft = { "markdown", "txt" },
  },
  -- {
  -- 	"psliwka/vim-smoothie",
  -- 	init = function()
  -- 		vim.cmd([[nnoremap <unique> <C-e> <cmd>call smoothie#do("\<C-D>") <CR>]])
  -- 		vim.cmd([[nnoremap <unique> <C-u> <cmd>call smoothie#do("\<C-U>") <CR>]])
  -- 	end
  -- },
  {
    "NvChad/nvim-colorizer.lua",
    -- event = "VeryLazy",
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
  { "theniceboy/antovim", lazy = false },
  { "gcmt/wildfire.vim", lazy = false },
  {
    "gbprod/substitute.nvim",
    config = function()
      local substitute = require "substitute"
      substitute.setup {
        highlight_substituted_text = {
          enabled = true,
          timer = 200,
        },
      }
      vim.keymap.set("n", "st", substitute.operator, { noremap = true, desc = "substitute with motion" })
      vim.keymap.set("n", "sh", function()
        substitute.operator { motion = "e" }
      end, { noremap = true })
      vim.keymap.set("x", "s", require("substitute.range").visual, { noremap = true })
      vim.keymap.set("n", "ss", substitute.line, { noremap = true, desc = "substitute with line" })
      vim.keymap.set("n", "sI", substitute.eol, { noremap = true })
      vim.keymap.set("x", "s", substitute.visual, { noremap = true, desc = "substitute with visual" })
      vim.keymap.set(
        "n",
        "sx",
        require("substitute.exchange").operator,
        { noremap = true, desc = "exchange with motion" }
      )
      vim.keymap.set("x", "X", require("substitute.exchange").visual, { noremap = true })
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
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("ufo").setup()
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
      },
    },
  },
}

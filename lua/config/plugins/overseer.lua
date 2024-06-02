local custom = {
  border = "rounded",
}

---@type LazyPluginSpec
return {
  "stevearc/overseer.nvim",
  enabled = true,
  opts = function()
    return {
      strategy = {
        "toggleterm",
        quit_on_exit = "success",
        open_on_start = false,
      },
      dap = false,
      form = {
        border = custom.border,
      },
      confirm = {
        border = custom.border,
      },
      task_win = {
        border = custom.border,
      },
      component_aliases = {
        default = {
          { "display_duration", detail_level = 2 },
          "on_output_summarize",
          "on_exit_set_status",
          "on_complete_notify",
          "on_complete_dispose",
          "unique",
        },
      },
    }
  end,
  config = function(_, opts)
    local overseer = require "overseer"

    overseer.setup(opts)

    do -- For lazy loading lualine component
      local success, lualine = pcall(require, "lualine")
      if not success then
        return
      end
      local lualine_cfg = lualine.get_config()
      for i, item in ipairs(lualine_cfg.sections.lualine_x) do
        if type(item) == "table" and item.name == "overseer-placeholder" then
          lualine_cfg.sections.lualine_x[i] = "overseer"
        end
      end
      lualine.setup(lualine_cfg)
    end

    local templates = {
      --typescript build single file
      {
        name = "TypeScript/javscript run single file",
        builder = function()
          return {
            cmd = { "bun" },
            args = { "run", vim.fn.expand "%:p" },
          }
        end,
        condition = {
          filetype = { "typescript" },
        },
      },
      -- c build single file
      {
        name = "C build single file",
        builder = function()
          return {
            cmd = { "clang" },
            args = {
              "-g",
              vim.fn.expand "%:p",
              "-o",
              vim.fn.expand "%:p:t:r",
            },
          }
        end,
        condition = {
          filetype = { "c" },
        },
      },
      {
        name = "C++ build single file",
        builder = function()
          return {
            cmd = { "g++" },
            args = {
              "-g",
              vim.fn.expand "%:p",
              "-o",
              vim.fn.expand "%:p:t:r",
            },
          }
        end,
        condition = {
          filetype = { "cpp" },
        },
      },
      --python build single file
      {
        name = "Python build single file",
        builder = function()
          return {
            cmd = { "python3" },
            args = { vim.fn.expand "%:p" },
          }
        end,
        condition = {
          filetype = { "python" },
        },
      },
      --lua build single file
      {
        name = "Lua build single file",
        builder = function()
          return {
            cmd = { "lua" },
            args = { vim.fn.expand "%:p" },
          }
        end,
        condition = {
          filetype = { "lua" },
        },
      },
      --elixir build single file
      {
        name = "Elixir build single file",
        builder = function()
          return {
            cmd = { "elixir" },
            args = { vim.fn.expand "%:p" },
          }
        end,
        condition = {
          filetype = { "elixir" },
        },
      },
      --ocaml build single file
      {
        name = "OCaml build single file",
        builder = function()
          return {
            cmd = { "ocamlc" },
            args = { vim.fn.expand "%:p" },
          }
        end,
        condition = {
          filetype = { "ocaml" },
        },
      },
    }
    for _, template in ipairs(templates) do
      overseer.register_template(template)
    end
  end,
  keys = {
    { "<leader>rr", "<cmd>OverseerRun<CR>", desc = "Run" },
    { "<leader>rl", "<cmd>OverseerToggle<CR>", desc = "List" },
    { "<leader>rn", "<cmd>OverseerBuild<CR>", desc = "New" },
    { "<leader>ra", "<cmd>OverseerTaskAction<CR>", desc = "Action" },
    { "<leader>ri", "<cmd>OverseerInfo<CR>", desc = "Info" },
    { "<leader>rc", "<cmd>OverseerClearCache<CR>", desc = "Clear cache" },
  },
}

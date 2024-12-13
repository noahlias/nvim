---@type LazyPluginSpec
return {
  "rcarriga/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- Adapters
    -- "nvim-neotest/neotest-jest",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
    "marilari88/neotest-vitest",
    "lawrence-laz/neotest-zig",
  },
  opts = function()
    return {
      adapters = {
        -- require "neotest-jest",
        require "neotest-go",
        require "neotest-python" {
          dap = {
            justMyCode = false,
          },
          runner = "pytest",
          pytest_discover_instances = true,
        },
        require "neotest-zig" {
          dap = {
            adapter = "lldb",
          },
        },
        require "neotest-vitest" {
          ---@diagnostic disable-next-line: unused-local
          filter_dir = function(name, rel_path, root)
            return name ~= "node_modules"
          end,
        },
        require "rustaceanvim.neotest",
      },
      consumers = {
        overseer = require "neotest.consumers.overseer",
      },
    }
  end,
  config = function(_, opts)
    require("neotest").setup(opts)
  end,
  keys = {
    {
      "<leader>Tr",
      function()
        require("neotest").run.run()
      end,
      desc = "Run",
    },
    {
      "<leader>Ts",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop",
    },
    {
      "<leader>Ta",
      function()
        require("neotest").run.attach()
      end,
      desc = "Attach",
    },

    {
      "<leader>Tm",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Summary",
    },
    {
      "<leader>Tw",
      function()
        require("neotest").watch.toggle()
      end,
      desc = "Watch",
    },
    {
      "<leader>To",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Output panel",
    },
  },
}

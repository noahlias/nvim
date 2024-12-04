local compile = function()
  vim.cmd "write"
  local filetype = vim.bo.filetype
  if filetype == "cpp" or filetype == "c" then
    os.execute("clang " .. vim.fn.expand "%" .. " -g -o " .. vim.fn.expand "%<")
  end
end

--- @type LazyPluginSpec
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "ravenxrz/DAPInstall.nvim",
      config = function()
        local dap_install = require "dap-install"
        dap_install.setup {
          installation_path = vim.fn.stdpath "data" .. "/dapinstall/",
        }
      end,
    },
    "theHamsta/nvim-dap-virtual-text",
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        "nvim-neotest/nvim-nio",
      },
    },
    "nvim-dap-virtual-text",
    {
      "mfussenegger/nvim-dap-python",
      ft = { "python" },
      config = function()
        require("dap-python").setup "python3"
        --- NOTE: This is for Python
        table.insert(require("dap").configurations.python, {
          name = "Launch file with repl highlights",
          type = "python",
          request = "launch",
          program = "${file}",
          repl_lang = "python",
        })
        table.insert(require("dap").configurations.python, {
          type = "python",
          request = "attach",
          name = "Remote Python: Attach",
          port = 5678,
          host = "127.0.0.1",
          mode = "remote",
          cwd = vim.fn.getcwd(),
          pathMappings = {
            {
              localRoot = function()
                return vim.fn.input(
                  "Local code folder > ",
                  vim.fn.getcwd(),
                  "file"
                )
              end,
              remoteRoot = function()
                return vim.fn.input("Container code folder > ", "/", "file")
              end,
            },
          },
        })
      end,
    },
    {
      "leoluz/nvim-dap-go",
      ft = { "go" },
      opts = {},
    },
    -- {
    --   "jbyuki/one-small-step-for-vimkind",
    --   keys = {
    --     {
    --       "<leader>Dr",
    --       function()
    --         require("osv").launch { port = 8086 }
    --       end,
    --       desc = "Run",
    --     },
    --     {
    --       "<leader>Ds",
    --       function()
    --         require("osv").stop()
    --       end,
    --       desc = "Stop",
    --     },
    --   },
    -- },
  },
  keys = {
    {
      "<leader>'t",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle breakpoint",
    },
    {
      "<leader>'v",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Hover",
    },
    {
      "<leader>'n",
      function()
        compile()
        require("dap").continue()
      end,
      desc = "Continue",
    },
    {
      "<leader>'s",
      function()
        require("dap").step_over()
      end,
      desc = "Step over",
    },
    {
      "<leader>'q",
      function()
        require("dap").terminate()
      end,
      desc = "Quit",
    },
    {
      "<leader>'u",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle UI",
    },
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    dapui.setup()
    require("nvim-dap-virtual-text").setup {}

    vim.api.nvim_set_hl(
      0,
      "DapBreakpoint",
      { ctermbg = 0, fg = "#993939", bg = "#31353f" }
    )
    vim.api.nvim_set_hl(
      0,
      "DapLogPoint",
      { ctermbg = 0, fg = "#61afef", bg = "#31353f" }
    )
    vim.api.nvim_set_hl(
      0,
      "DapStopped",
      { ctermbg = 0, fg = "#ffffff", bg = "#FE3C25" }
    )

    vim.fn.sign_define("DapBreakpoint", {
      text = "",
      texthl = "DapBreakpoint",
      linehl = "DapBreakpoint",
      numhl = "DapBreakpoint",
    })
    vim.fn.sign_define("DapBreakpointCondition", {
      text = "ﳁ",
      texthl = "DapBreakpoint",
      linehl = "DapBreakpoint",
      numhl = "DapBreakpoint",
    })
    vim.fn.sign_define("DapBreakpointRejected", {
      text = "",
      texthl = "DapBreakpoint",
      linehl = "DapBreakpoint",
      numhl = "DapBreakpoint",
    })
    vim.fn.sign_define("DapLogPoint", {
      text = "",
      texthl = "DapLogPoint",
      linehl = "DapLogPoint",
      numhl = "DapLogPoint",
    })
    vim.fn.sign_define("DapStopped", {
      text = "",
      texthl = "DapStopped",
      linehl = "DapStopped",
      numhl = "DapStopped",
    })
    -- NOTE: this plugin for neovim debug
    dap.defaults.fallback.external_terminal = {
      command = "/Applications/kitty.app/Contents/MacOS/kitty",
      args = {
        "--class",
        "kitty-dap",
        "--hold",
        "--detach",
        "nvim-dap",
        "-c",
        "DAP",
      },
    }
    --
    -- dap.adapters["nvim-lua"] = function(callback, config)
    --   callback {
    --     type = "server",
    --     host = config.host or "127.0.0.1",
    --     port = config.port or 8086,
    --   }
    -- end
    -- dap.configurations.lua = {
    --   {
    --     type = "nvim-lua",
    --     request = "attach",
    --     name = "Attach to running Neovim instance",
    --   },
    -- }

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.g.codelldb_path,
        args = { "--port", "${port}" },
      },
    }
    dap.adapters.lldb = {
      type = "executable",
      name = "lldb",
      command = "lldb-dap",
    }
    dap.configurations.cpp = {
      {
        name = "[Codelldb] Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/",
            "file"
          )
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
      {
        name = "[LLDB] Launch Executable",
        type = "lldb",
        request = "launch",
        program = require("utils.static").dap_pick_exec,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
      {
        name = "[LLDB] Attach to process",
        type = "lldb",
        request = "attach",
        pid = require("utils.static").dap_pick_process, -- utility to pick process using fzf-lua
        args = {},
      },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    -- NOTE: This is for OCaml
    dap.adapters.ocamlearlybird = {
      type = "executable",
      command = "ocamlearlybird",
      args = { "debug" },
    }
    dap.configurations.ocaml = {
      {
        name = "OCaml Debug test.bc",
        type = "ocamlearlybird",
        request = "launch",
        program = "${workspaceFolder}/_build/default/test/test.bc",
      },
      {
        name = "OCaml Debug main.bc",
        type = "ocamlearlybird",
        request = "launch",
        program = "${workspaceFolder}/_build/default/bin/main.bc",
      },
    }
    ---@diagnostic disable-next-line: undefined-field
    require("overseer").enable_dap(true)
    require("dap.ext.vscode").json_decode = require("overseer.json").decode
  end,
}

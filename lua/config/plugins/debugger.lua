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
    "nvim-telescope/telescope-dap.nvim",
    {
      "mfussenegger/nvim-dap-python",
      ft = { "python" },
      config = function()
        require("dap-python").setup(
          -- vim.fs.joinpath(require("mason-registry").get_package("debugpy"):get_install_path(), "venv/bin/python")
        )
        --- NOTE: This is for Python
        table.insert(require("dap").configurations.python, {
          name = "Launch file with repl highlights",
          type = "python",
          request = "launch",
          program = "${file}",
          repl_lang = "python",
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
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    dapui.setup()
    require("nvim-dap-virtual-text").setup {}

    -- dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    -- dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    -- dap.listeners.before.event_exited["dapui_config"] = dapui.close

    vim.keymap.set("n", "<leader>'t", dap.toggle_breakpoint, { desc = "Toggle breakpoint", noremap = true })
    vim.keymap.set("n", "<leader>'v", require("dap.ui.widgets").hover, { desc = "Hover", noremap = true })
    vim.keymap.set("n", "<leader>'n", function()
      compile()
      dap.continue()
    end, { desc = "Continue", noremap = true })
    vim.keymap.set("n", "<leader>'s", dap.step_over, { desc = "Step over", noremap = true })
    local widgets = require "dap.ui.widgets"
    vim.keymap.set("n", "<leader>'q", dap.terminate, { desc = "Quit", noremap = true })
    vim.keymap.set("n", "<leader>'u", dapui.toggle, { noremap = true, desc = "Toggle UI" })

    vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#ffffff", bg = "#FE3C25" })

    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
      "DapBreakpointRejected",
      { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define("DapLogPoint", {
      text = "",
      texthl = "DapLogPoint",
      linehl = "DapLogPoint",
      numhl = "DapLogPoint",
    })
    vim.fn.sign_define(
      "DapStopped",
      { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
    )
    -- NOTE: this plugin for neovim debug
    -- dap.defaults.fallback.external_terminal = {
    --   command = "/Applications/kitty.app/Contents/MacOS/kitty",
    --   args = { "--class", "kitty-dap", "--hold", "--detach", "nvim-dap", "-c", "DAP" },
    -- }
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
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          local exe = vim.g.c_debug_program or vim.fn.expand "%:r"
          return vim.fn.getcwd() .. "/" .. exe
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
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
    local dap_install = require "dap-install"
    dap_install.config("codelldb", {})

    require("overseer").enable_dap(true)
  end,
}

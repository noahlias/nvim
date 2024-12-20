---@type LazyPluginSpec
return {
  "mfussenegger/nvim-jdtls",
  event = {
    "BufRead *.java",
    "BufNewFile *.java",
  },
  opts = function()
    -- local jdtls = require "jdtls"
    local mason = require "mason-registry"
    local capabilities = require "config.capabilities"

    return {
      cmd = {
        vim.fs.joinpath(
          mason.get_package("jdtls"):get_install_path(),
          "/bin/jdtls"
        ),
      },
      root_dir = vim.fs.dirname(
        vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]
      ),

      handlers = {
        ["language/status"] = function() end,
      },
      settings = {
        java = {
          inlayHints = {
            parameterNames = {
              enabled = "all",
            },
          },
        },
      },
      capabilities = capabilities,
      init_options = {
        bundles = {
          vim.fn.glob(
            vim.fs.joinpath(
              mason.get_package("java-debug-adapter"):get_install_path(),
              "extension/server/com.microsoft.java.debug.plugin-*.jar"
            ),
            true
          ),
        },
      },
    }
  end,
  config = function(_, opts)
    local jdtls = require "jdtls"

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      desc = "Attach jdtls",
      callback = function()
        ---@diagnostic disable-next-line: missing-fields
        jdtls.start_or_attach(opts, { dap = { hotcodereplace = "auto" } })
        vim.bo.tabstop = 4
        vim.opt_local.colorcolumn = "100"
      end,
    })
  end,
}

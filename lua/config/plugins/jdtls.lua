---@type LazyPluginSpec
return {
  "mfussenegger/nvim-jdtls",
  event = {
    "BufRead *.java",
    "BufNewFile *.java",
  },
  opts = function()
    -- local jdtls = require "jdtls"
    local capabilities = require "config.capabilities"

    local mason_path = vim.fs.joinpath(vim.fn.stdpath "data", "mason")

    return {
      cmd = {
        vim.fs.joinpath(mason_path, "packages", "jdtls", "bin", "jdtls"),
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
          vim.fs.joinpath(
            mason_path,
            "packages",
            "jdtls",
            "extension",
            "server",
            "com.microsoft.java.test.plugin-*.jar"
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

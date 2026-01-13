---@type LazyPluginSpec
return {
  "Civitasv/cmake-tools.nvim",
  ft = { "c", "cpp", "cmake" },
  opts = {
    cmake_build_options = { "--parallel 8" }, -- this will be passed when invoke `CMakeBuild`
    cmake_build_directory = function()
      return "build/${variant:buildType}"
    end, -- this is used to specify generate directory for cmake, allows macro expansion, can be a string or a function returning the string, relative to cwd.
    cmake_executor = {
      name = "overseer",
    },
    cmake_runner = {
      name = "overseer",
    },
  },
}

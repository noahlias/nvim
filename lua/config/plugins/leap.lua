return {
  {
    "echasnovski/mini.jump2d",
    version = false,
    config = function()
      require("mini.jump2d").setup {
        mappings = {
          start_jumping = "<Esc>",
        },
      }
    end,
  },
  {
    "echasnovski/mini.jump",
    version = false,
    config = function()
      require("mini.jump").setup()
    end,
  },
}

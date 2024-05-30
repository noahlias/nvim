local split = function()
  vim.cmd "set splitbelow"
  vim.cmd "sp"
  vim.cmd "res -5"
end
local compileRun = function()
  vim.cmd "w"
  -- check file type
  local ft = vim.bo.filetype
  if ft == "dart" then
    vim.cmd(":FlutterRun -d " .. vim.g.flutter_default_device .. " " .. vim.g.flutter_run_args .. "<CR>")
  elseif ft == "markdown" then
    vim.cmd ":InstantMarkdownPreview<CR>"
  elseif ft == "lua" then
    split()
    vim.cmd "term luajit %"
  elseif ft == "python" then
    split()
    vim.cmd "term python3 %"
  elseif ft == "javascript" or ft == "typescript" then
    split()
    vim.cmd "term bun %"
  elseif ft == "elixir" then
    split()
    vim.cmd "term elixir %"
  elseif ft == "ocaml" then
    split()
    vim.cmd "term ocaml %"
  elseif ft == "zig" then
    split()
    vim.cmd "term zig run %"
  elseif ft == "hurl" then
    split()
    vim.cmd "term hurl %"
  end
end

local chooseVisualFormatAndRun = function()
  local formats = {
    "beams",
    "binarypath",
    "blackhole",
    "bouncyballs",
    "bubbles",
    "burn",
    "colorshift",
    "crumble",
    "decrypt",
    "errorcorrect",
    "expand",
    "fireworks",
    "middleout",
    "orbittingvolley",
    "overflow",
    "pour",
    "print",
    "rain",
    "randomsequence",
    "rings",
    "scattered",
    "slice",
    "slide",
    "spotlights",
    "spray",
    "swarm",
    "synthgrid",
    "unstable",
    "vhstape",
    "waves",
    "wipe",
  }
  -- local choice = vim.fn.inputlist(formats)
  vim.ui.select(formats, { prompt = "Choose a visual format: " }, function(choice)
    vim.cmd "w"
    split()
    if choice ~= nil then
      vim.cmd("term cat % | tte " .. choice)
    end
  end)
end

vim.keymap.set("n", "r", compileRun, { silent = true })
vim.keymap.set("n", "<leader>tt", chooseVisualFormatAndRun, { silent = true, desc = "TTE with visual effects" })

vim.cmd [[
  augroup MarkdownCommands
    autocmd!
    autocmd FileType markdown command! MarkdownOpenWithChrome :silent !open -a 'Google Chrome' %
  augroup END
]]

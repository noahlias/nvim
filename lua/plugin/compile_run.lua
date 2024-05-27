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

vim.keymap.set("n", "r", compileRun, { silent = true })

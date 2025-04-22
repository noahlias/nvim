---- Source :https://github.com/tamton-aquib/stuff.nvim/blob/main/lua/rain.lua
-- FIX: Gets stuck after sometime.
local M = {}

local running = nil
local win = nil

M.rain = function()
  local ns = vim.api.nvim_create_namespace "rain"
  local N = 5
  local CHAR = "" -- "" -- "|" -- "💧"

  local buf = vim.api.nvim_create_buf(false, true)
  win = vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    style = "minimal",
    border = "none",
    width = vim.o.columns,
    height = vim.o.lines,
    row = 0,
    col = 0,
  })
  vim.api.nvim_buf_set_lines(
    buf,
    0,
    vim.o.lines,
    false,
    (function()
      local stuff = {}
      for _ = 1, vim.o.lines do
        table.insert(stuff, (" "):rep(vim.o.columns))
      end
      return stuff
    end)()
  )
  vim.cmd [[hi NormalFloat guibg=none]]
  vim.wo[win].winblend = 100

  local counter = 0
  local function startRain()
    if running == false then
      return
    end
    local numbers = {}
    for _ = 1, N do
      local n = math.random(1, vim.o.columns)
      table.insert(numbers, { c = n, l = 0 })
    end

    for _, d in ipairs(numbers) do
      local id = vim.api.nvim_buf_set_extmark(
        buf,
        ns,
        d.l,
        d.c,
        { virt_text = { { CHAR, "Identifier" } }, virt_text_pos = "overlay" }
      )

      -- TODO: should these go above?
      -- FIXME: Performance issue will stuck
      counter = counter + 1
      local function startDrop()
        if running == false then
          vim.api.nvim_buf_del_extmark(buf, ns, id)
          return
        end
        if d.l >= vim.o.lines - 1 or d.c >= vim.o.columns - 1 then
          vim.api.nvim_buf_del_extmark(buf, ns, id)
          return
        end
        vim.api.nvim_buf_set_extmark(buf, ns, d.l, d.c, {
          virt_text = { { CHAR, "Identifier" } },
          virt_text_pos = "overlay",
          id = id,
        })
        d.l = d.l + 1
        d.c = d.c + 1
        vim.defer_fn(startDrop, 35)
      end
      vim.defer_fn(startDrop, 0)
    end
    vim.defer_fn(startRain, 500)
  end
  vim.defer_fn(startRain, 1000)
end

M.toggle_rain = function()
  if running then
    running = false
    if win then
      vim.api.nvim_win_close(win, true)
      win = nil
    end
  else
    running = true
    M.rain()
  end
end
return M

local M = {}

-- 词汇对照表 - 只有在需要时才会初始化
local word_pairs = nil

-- 初始化词汇对照表的函数
local function init_word_pairs()
  if word_pairs then
    return
  end

  word_pairs = {
    -- 数字
    ["0"] = "1",
    ["1"] = "0",

    -- 布尔值 (小写)
    ["true"] = "false",
    ["false"] = "true",

    -- 布尔值 (首字母大写)
    ["True"] = "False",
    ["False"] = "False",

    -- 布尔值 (全大写)
    ["TRUE"] = "FALSE",
    ["FALSE"] = "TRUE",

    -- 开关
    ["on"] = "off",
    ["off"] = "on",
    ["On"] = "Off",
    ["Off"] = "On",
    ["ON"] = "OFF",
    ["OFF"] = "ON",

    -- 启用/禁用
    ["enable"] = "disable",
    ["disable"] = "enable",
    ["enabled"] = "disabled",
    ["disabled"] = "enabled",
    ["Enable"] = "Disable",
    ["Disable"] = "Enable",
    ["Enabled"] = "Disabled",
    ["Disabled"] = "Enabled",

    -- 显示/隐藏
    ["show"] = "hide",
    ["hide"] = "show",
    ["Show"] = "Hide",
    ["Hide"] = "Show",
    ["visible"] = "hidden",
    ["hidden"] = "visible",

    -- 开始/结束
    ["start"] = "end",
    ["end"] = "start",
    ["Start"] = "End",
    ["End"] = "Start",
    ["begin"] = "end",
    ["Begin"] = "End",

    -- 是/否
    ["yes"] = "no",
    ["no"] = "yes",
    ["Yes"] = "No",
    ["No"] = "Yes",
    ["YES"] = "NO",
    ["NO"] = "YES",

    -- 最大/最小
    ["max"] = "min",
    ["min"] = "max",
    ["Max"] = "Min",
    ["Min"] = "Max",
    ["maximum"] = "minimum",
    ["minimum"] = "maximum",

    -- 左/右
    ["left"] = "right",
    ["right"] = "left",
    ["Left"] = "Right",
    ["Right"] = "Left",

    -- 上/下
    ["up"] = "down",
    ["down"] = "up",
    ["Up"] = "Down",
    ["Down"] = "Up",
    ["top"] = "bottom",
    ["bottom"] = "top",
    ["Top"] = "Bottom",
    ["Bottom"] = "Top",

    -- 前/后
    ["before"] = "after",
    ["after"] = "before",
    ["Before"] = "After",
    ["After"] = "Before",
    ["front"] = "back",
    ["back"] = "front",
    ["Front"] = "Back",
    ["Back"] = "Front",

    -- 打开/关闭
    ["open"] = "close",
    ["close"] = "open",
    ["Open"] = "Close",
    ["Close"] = "Open",

    -- 输入/输出
    ["input"] = "output",
    ["output"] = "input",
    ["Input"] = "Output",
    ["Output"] = "Input",

    -- 加/减
    ["add"] = "remove",
    ["remove"] = "add",
    ["Add"] = "Remove",
    ["Remove"] = "Add",
    ["plus"] = "minus",
    ["minus"] = "plus",

    -- 包含/排除
    ["include"] = "exclude",
    ["exclude"] = "include",
    ["Include"] = "Exclude",
    ["Exclude"] = "Include",
  }
end

-- 切换单词的主函数
function M.toggle()
  -- 延迟初始化词汇表
  init_word_pairs()

  -- 获取当前光标位置
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  -- 获取当前行
  local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
  if not line then
    return
  end

  -- 找到光标下的单词
  local word_start, word_end = col, col

  -- 向前找单词开始位置
  while word_start > 0 and line:sub(word_start, word_start):match "[%w_]" do
    word_start = word_start - 1
  end
  word_start = word_start + 1

  -- 向后找单词结束位置
  while
    word_end < #line and line:sub(word_end + 1, word_end + 1):match "[%w_]"
  do
    word_end = word_end + 1
  end

  -- 提取当前单词
  local current_word = line:sub(word_start, word_end)

  -- 查找对应的切换词
  ---@diagnostic disable-next-line: need-check-nil
  local new_word = word_pairs[current_word]

  if new_word then
    -- 替换单词
    local new_line = line:sub(1, word_start - 1)
      .. new_word
      .. line:sub(word_end + 1)
    vim.api.nvim_buf_set_lines(0, row, row + 1, false, { new_line })

    -- 调整光标位置到新单词的开始
    vim.api.nvim_win_set_cursor(0, { row + 1, word_start - 1 })

    print("切换: " .. current_word .. " → " .. new_word)
  else
    print("未找到 '" .. current_word .. "' 的对应词")
  end
end

-- 添加新的词汇对
function M.add_pair(word1, word2)
  init_word_pairs()
  word_pairs[word1] = word2
  word_pairs[word2] = word1
end

-- -- 设置快捷键的函数
-- function M.setup(opts)
--   opts = opts or {}
--   local keymap = opts.keymap or "gs"
--
--   -- 设置键映射
--   vim.keymap.set("n", keymap, M.toggle, {
--     desc = "Toggle negative/positive words",
--     silent = true,
--   })
--
--   -- 创建用户命令
--   vim.api.nvim_create_user_command("ToggleWord", M.toggle, {})
--
--   -- 如果提供了额外的词汇对，添加它们
--   if opts.pairs then
--     for word1, word2 in pairs(opts.pairs) do
--       M.add_pair(word1, word2)
--     end
--   end
-- end

return M

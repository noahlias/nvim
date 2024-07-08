---@type LazyPluginSpec[]
return {
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_no_tab_map = true
      vim.cmd 'imap <silent><script><expr> <C-C> copilot#Accept("")'
      vim.cmd [[
			let g:copilot_filetypes = {
	       \ 'TelescopePrompt': v:false,
				 \ 'rip-substitute': v:false,
				 \ 'mini-files': v:false,
				 \ 'copilot-chat' : v:false,
	     \ }
			]]
    end,
  },
  {
    "robitx/gp.nvim",
    enabled = true,
    cmd = {
      -- Chat
      "GpChatNew",
      "GpChatToggle",
      "GpChatFinder",
    },
    keys = {
      -- Chat
      {
        "<C-g>c",
        "<Cmd>GpChatNew vsplit<CR>",
        mode = { "n", "i" },
        desc = "New Chat",
      },
      {
        "<C-g>c",
        ":<C-u>'<,'>GpChatNew vsplit<CR>",
        mode = { "v" },
        desc = "New Chat",
      },
      {
        "<C-g>t",
        "<Cmd>GpChatToggle vsplit<CR>",
        mode = { "n", "i" },
        desc = "Toggle Chat",
      },
      {
        "<C-g>t",
        ":<C-u>'<,'>GpChatToggle vsplit<CR>",
        mode = { "v" },
        desc = "Toggle Chat",
      },
      {
        "<C-g>f",
        "<Cmd>GpChatFinder<CR>",
        mode = { "n", "i" },
        desc = "Find Chat",
      },
      {
        "<C-g>p",
        ":<C-u>'<,'>GpChatPaste<CR>",
        mode = { "v" },
        desc = "Chat Paste",
      },
    },
    event = "VeryLazy",
    config = function()
      local config = {

        openai_api_key = {
          "gopass",
          "show",
          "-f",
          "-o",
          "websites/deepseek.com/noahlias",
        },
        openai_api_endpoint = "https://api.deepseek.com/v1/chat/completions",
        agents = {
          {
            name = "ChatDeepseek",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "deepseek-chat", temperature = 0.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a general AI assistant.\n\n"
              .. "The user provided the additional info about how they would like you to respond:\n\n"
              .. "- If you're unsure don't guess and say you don't know instead.\n"
              .. "- Ask question if you need clarification to provide better answer.\n"
              .. "- Think deeply and carefully from first principles step by step.\n"
              .. "- Zoom out first to see the big picture and then zoom in to details.\n"
              .. "- Use Socratic method to improve your thinking and coding skills.\n"
              .. "- Don't elide any code from your output if the answer requires coding.\n"
              .. "- Please try to explain it in Chinese if possible.\n"
              .. "- Take a deep breath; You've got this!\n",
          },
          {
            name = "CodeDeepseek",
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "deepseek-coder", temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are an AI working as a code editor.\n\n"
              .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
              .. "Please Don't add any extra comments or explanations.\n"
              .. "START AND END YOUR ANSWER WITH:\n\n```",
          },
        },
        chat_topic_gen_model = "deepseek-chat",
      }
      require("gp").setup(config)
      local function keymapOptions(desc)
        return {
          noremap = true,
          silent = true,
          nowait = true,
          desc = "GPT prompt " .. desc,
        }
      end

      -- Prompt commands
      vim.keymap.set(
        { "n", "i" },
        "<C-g>r",
        "<cmd>GpRewrite<cr>",
        keymapOptions "Inline Rewrite"
      )
      vim.keymap.set(
        "v",
        "<C-g>r",
        ":<C-u>'<,'>GpRewrite<cr>",
        keymapOptions "Visual Rewrite"
      )
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = true,
    branch = "canary",
    event = "VeryLazy",
    dependencies = {
      { "github/copilot.vim" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    config = function()
      local opts = {
        show_fold = false,
        show_help = false,
        model = "gpt-4",
        auto_follow_cursor = true,
        auto_inert_mode = true,
        question_header = "  " .. vim.g.snips_author .. " ", -- Header to use for user questions
        answer_header = "  Copilot ", -- Header to use for AI answers
        error_header = "", -- Header to use for errors
        window = {
          border = "rounded",
          width = 0.32,
          selection = function(source)
            local select = require "CopilotChat.select"
            return select.visual(source) or select.buffer(source)
          end,
        },
        mappings = {
          complete = {
            insert = "",
          },
          -- Close the chat
          close = {
            normal = "q",
            insert = "<C-q>",
          },
          -- Reset the chat buffer
          reset = {
            normal = "<C-l>",
            insert = "<C-l>",
          },
          -- Submit the prompt to Copilot
          submit_prompt = {
            normal = "<CR>",
            insert = "<C-CR>",
          },
        },
        selection = function(source)
          local select = require "CopilotChat.select"
          return select.visual(source) or select.buffer(source)
        end,
      }

      vim.api.nvim_set_hl(
        0,
        "CopilotChatSeparator",
        { fg = "#7a8d76", bg = "none" }
      )
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
          vim.opt_local.fillchars = "eob: "
        end,
      })

      require("CopilotChat").setup(opts)
      require("CopilotChat.integrations.cmp").setup()
    end,
    keys = {
      -- Show prompts actions with telescope
      {
        "<leader>ax",
        function()
          require("CopilotChat").toggle()
        end,
        desc = "CopilotChat - chat",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          local input = vim.fn.input "Quick Chat: "
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "CopilotChat - Quick chat",
        mode = { "n", "v" },
      },
      {
        "<leader>ah",
        function()
          local actions = require "CopilotChat.actions"
          require("CopilotChat.integrations.fzflua").pick(
            actions.help_actions()
          )
        end,
        desc = "CopilotChat - Help actions",
      },
      -- Show prompts actions with fzf-lua
      {
        "<leader>ap",
        function()
          local actions = require "CopilotChat.actions"
          require("CopilotChat.integrations.fzflua").pick(
            actions.prompt_actions()
          )
        end,
        desc = "CopilotChat - Prompt actions",
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  -- NOTE: temporaily disable this plugin  <04/26, 2024, noahlias> --
  {
    "Exafunction/codeium.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup {}
    end,
  },
  -- TODO: cody integrations  <04/27, 2024, noahlias> --
  {
    "sourcegraph/sg.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]]
    },
  },
}

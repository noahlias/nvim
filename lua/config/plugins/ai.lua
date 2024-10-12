---@type LazyPluginSpec[]
return {
  {
    "github/copilot.vim",
    event = { "BufNewFile", "BufReadPost" },
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
      local system_prompt = "You are a general AI assistant.\n\n"
        .. "The user provided the additional info about how they would like you to respond:\n\n"
        .. "- If you're unsure don't guess and say you don't know instead.\n"
        .. "- Ask question if you need clarification to provide better answer.\n"
        .. "- Think deeply and carefully from first principles step by step.\n"
        .. "- Zoom out first to see the big picture and then zoom in to details.\n"
        .. "- Use Socratic method to improve your thinking and coding skills.\n"
        .. "- Don't elide any code from your output if the answer requires coding.\n"
        .. "- Please try to explain it in Chinese if possible.\n"
        .. "- Take a deep breath; You've got this!\n"
      local default_code_system_prompt = "You are an AI working as a code editor.\n\n"
        .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
        .. "START AND END YOUR ANSWER WITH:\n\n```"
      local config = {
        providers = {
          openai = {
            endpoint = "https://api.deepseek.com/v1/chat/completions",
            secret = {
              "gopass",
              "show",
              "-f",
              "-o",
              "websites/deepseek.com/noahlias",
            },
          },
          github_llm = {
            endpoint = "https://models.inference.ai.azure.com/chat/completions",
            secret = {
              "gopass",
              "show",
              "-f",
              "-o",
              "websites/github.com/noahlias",
            },
          },
          copilot = {
            endpoint = "https://api.githubcopilot.com/chat/completions",
            secret = {
              "bash",
              "-c",
              "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
            },
          },
          ollama = {
            endpoint = "http://localhost:11434/v1/chat/completions",
          },
          googleai = {
            endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
            secret = {
              "gopass",
              "show",
              "-f",
              "-o",
              "websites/gemini.com/noahlias",
            },
          },
        },
        agents = {
          {
            name = "ChatDeepseek",
            chat = true,
            provider = "openai",
            command = false,
            model = { model = "deepseek-chat", temperature = 0.1, top_p = 1 },
            system_prompt = system_prompt,
          },
          {
            name = "GithubGpt4o",
            chat = true,
            provider = "github_llm",
            command = true,
            model = { model = "gpt-4o", temperature = 0.1, top_p = 1 },
            system_prompt = system_prompt,
          },
          {
            name = "GithubGpt4o-mini",
            chat = true,
            provider = "github_llm",
            command = true,
            model = { model = "gpt-4o-mini", temperature = 0.1, top_p = 1 },
            system_prompt = system_prompt,
          },
          {
            name = "GithubCopilot",
            chat = true,
            provider = "copilot",
            command = true,
            model = { model = "gpt-4o", temperature = 0.1, top_p = 1 },
            system_prompt = system_prompt,
          },
          {
            name = "GeminiPro",
            chat = true,
            provider = "googleai",
            command = true,
            model = {
              model = "gemini-1.5-pro-latest",
              temperature = 0.1,
              top_p = 1,
            },
            system_prompt = system_prompt,
          },
          {
            name = "Qwen2",
            chat = true,
            provider = "ollama",
            command = true,
            model = {
              model = "qwen2",
              temperature = 0.1,
              top_p = 1,
            },
            system_prompt = system_prompt,
          },
          {
            name = "Gemma2",
            chat = true,
            provider = "ollama",
            command = true,
            model = {
              model = "gemma2:2b",
              temperature = 0.1,
              top_p = 1,
            },
            system_prompt = system_prompt,
          },
          {
            name = "CodeQwen",
            chat = true,
            provider = "ollama",
            command = true,
            model = {
              model = "codeqwen",
              temperature = 0.1,
              top_p = 1,
            },
            system_prompt = system_prompt,
          },
          {
            name = "CodeDeepseek",
            chat = false,
            command = true,
            provider = "openai",
            model = { model = "deepseek-coder", temperature = 0.8, top_p = 1 },
            system_prompt = default_code_system_prompt,
          },
        },
        chat_topic_gen_model = "deepseek-chat",
        style_chat_finder_border = "rounded",
        chat_template = require("gp.defaults").short_chat_template,
        style_chat_finder_margin_left = 5,
        style_chat_finder_margin_right = 5,
        style_chat_finder_margin_top = 5,
        hooks = {
          UnitTests = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please respond by writing table driven unit tests for the code above."
            local agent = gp.get_command_agent()
            gp.Prompt(params, gp.Target.vnew, agent, template)
          end,
          CodeReview = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please analyze for code smells and suggest improvements."
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.enew "markdown", agent, template)
          end,
          Translator = function(gp, params)
            local chat_system_prompt =
              "You are a Translator, please translate between English and Chinese."
            local agent = gp.get_chat_agent "GithubCopilot"
            gp.cmd.ChatNew(params, chat_system_prompt, agent)
          end,
        },
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
    cmd = "CopilotChat",
    dependencies = {
      { "github/copilot.vim" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    config = function()
      local opts = {
        show_fold = false,
        show_help = false,
        auto_follow_cursor = true,
        auto_inert_mode = true,
        question_header = "  " .. vim.g.snips_author .. " ", -- Header to use for user questions
        answer_header = "  Copilot ", -- Header to use for AI answers
        error_header = "", -- Header to use for errors
        window = {
          border = "rounded",
          width = 0.45,
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
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<c-s>",
        "<CR>",
        ft = "copilot-chat",
        desc = "Submit Prompt",
        remap = true,
      },
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
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    enabled = true,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
      provider = "copilot",
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.icons",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}

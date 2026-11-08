local window = require("utils.window")
local prompts = require("configs.llm.prompts")

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dev = true,
  branch = "main",
  build = "make tiktoken",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "zbirenbaum/copilot.lua",
  },

  opts = function()
    return {
      system_prompt = prompts.system_prompt,
      prompts = prompts.prompts,

      resources = "selection",
      selection = "visual",

      temperature = 0.1,

      -- I only use FREE models cause I am poor asf
      -- model = "openai/gpt-oss-120b",
      model = "gemini-3.5-flash-lite",
      -- model = "gemini-3.6-flash",

      providers = require("configs.llm.providers").setup(),

      window = {
        layout = "vertical",
        width = 0.45,
      },

      headers = {
        user = " r4ppz",
        assistant = "󱚝  Vix",
        tool = " Tool",
      },
      separator = "─",
      highlight_headers = true,

      auto_fold = true,
      show_folds = true,
      auto_insert_mode = false,
      auto_follow_cursor = false,
      insert_at_end = false,
      show_help = false,
      clear_chat_on_new_prompt = false,
      remember_as_sticky = false,

      instruction_files = {
        -- I am not goint to vibe code using this plugin lol
      },

      trusted_tools = { "file", "glob", "grep" },
    }
  end,

  keys = {
    {
      "<leader>ci",
      function()
        window.close_panels()
        vim.cmd("CopilotChatIdiomatic")
      end,
      mode = { "n", "v" },
      desc = "Check if code is idiomatic",
    },

    {
      "<leader>ce",
      function()
        window.close_panels()
        vim.cmd("CopilotChatExplain")
      end,
      mode = { "n", "v" },
      desc = "Explain code",
    },

    {
      "<leader>cs",
      function()
        window.close_panels()
        vim.cmd("CopilotChatSuggest")
      end,
      mode = { "n", "v" },
      desc = "Suggest alternatives",
    },

    {
      "<leader>cm",
      "<CMD>CopilotChatModels<CR>",
      mode = { "n", "v" },
      desc = "View/select available models",
    },

    {
      "<M-c>",
      function()
        window.toggle_panel(function()
          require("CopilotChat").toggle()
        end, "copilot-chat")
      end,
      mode = { "n", "v", "i" },
      desc = "Toggle CopilotChat",
    },

    {
      "<leader>cp",
      function()
        window.close_panels()
        local chat = require("CopilotChat")
        chat.open()
        chat.select_prompt()
      end,
      mode = { "n", "v" },
      desc = "View/select prompt templates",
    },

    -- Open chat with current buffer
    {
      "<leader>cb",
      function()
        window.close_panels()
        local chat = require("CopilotChat")
        chat.open()
        chat.chat:add_message({ role = "user", content = "#buffer:active\n" })
      end,
      mode = { "n", "v" },
      desc = "Open chat with current buffer",
    },

    {
      "<leader>cB",
      function()
        window.close_panels()
        local chat = require("CopilotChat")
        chat.open()
        chat.chat:add_message({ role = "user", content = "#buffer:listed\n" })
      end,
      mode = { "n", "v" },
      desc = "Open chat with all buffers",
    },

    {
      "<leader>cf",
      function()
        local chat = require("utils.chat")
        chat.pick_file()
      end,
      desc = "Add files to CopilotChat",
      mode = { "n", "v" },
    },

    {
      "<leader>ck",
      function()
        local chat = require("utils.chat")
        chat.better_hover()
      end,
      desc = "Explain hover with Copilot",
      mode = { "n", "v" },
    },

    {
      "<C-S-M-Up>",
      function()
        local chat = require("utils.chat")
        chat.better_hover()
      end,
      desc = "Explain hover with Copilot",
      mode = { "n", "v" },
    },
  },
}

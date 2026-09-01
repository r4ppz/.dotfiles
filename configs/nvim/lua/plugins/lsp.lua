local servers = require("configs.servers.servers")

return {
  {
    "neovim/nvim-lspconfig",
    event = "FileType",

    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem = {
        documentationFormat = {
          "markdown",
          "plaintext",
        },
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
          properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
          },
        },
      }

      vim.diagnostic.config({
        virtual_text = false,
        signs = false,
        underline = false,
        update_in_insert = false,

        float = {
          max_width = 70,
        },
      })

      vim.lsp.document_color.enable(false, nil, { style = "virtual" })

      vim.lsp.config("*", {
        capabilities = capabilities,
        root_markers = { ".git" },
      })

      servers.setup(capabilities)

      for _, s in ipairs(servers.lsp_list) do
        vim.lsp.enable(s)
      end
    end,
  },

  {
    "folke/trouble.nvim",
    event = "LspAttach",
    opts = {
      auto_close = true,
      focus = true,
      warn_no_results = false,
      keys = {
        ["<cr>"] = "jump_close",
      },
    },
  },

  {
    "r4ppz/lspeek.nvim",
    event = "LspAttach",
    opts = {
      window = {
        width = 70,
        height = 15,
        border = "single",
      },

      stack_limit = 10,
      select_first = false,

      keymaps = {
        close = "q",
        split = "s",
        vsplit = "v",
        enter = "<CR>",
      },
    },
  },
}

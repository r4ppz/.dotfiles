return {
  {
    "brianhuster/live-preview.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    keys = {
      {
        "<leader>up",
        "<cmd>LivePreview start<CR>",
        desc = "Start Live Preview",
      },
    },
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      local spec = require("markview.spec")

      -- Highlight group and icon used for ALL links
      local link_hl = "MarkviewHyperlink"
      local link_icon = "󰌷 "

      -- Enforces a unified icon and highlight
      local function unify_links(path, hl, icon)
        local original = spec.get(path, { fallback = {} })
        local modified = {}
        for pattern, conf in pairs(original) do
          if type(conf) == "table" then
            modified[pattern] = vim.tbl_extend("force", conf, {
              icon = icon ~= nil and icon or conf.icon,
              hl = hl or conf.hl,
              icon_hl = hl or conf.icon_hl,
              file_hl = conf.file_hl and (hl or conf.file_hl) or nil,
              block_hl = conf.block_hl and (hl or conf.block_hl) or nil,
            })
          else
            modified[pattern] = conf
          end
        end
        return modified
      end

      return {
        preview = {
          modes = { "n", "no", "c" },
          hybrid_modes = {},
          filetypes = { "markdown", "copilot-chat" },
          ignore_buftypes = {},
        },

        html = {
          enable = true,
        },

        latex = {
          enable = true,
        },

        markdown = {
          headings = {
            enable = true,
            shift_width = 0,

            heading_1 = { style = "simple" },
            heading_2 = { style = "simple" },
            heading_3 = { style = "simple" },
            heading_4 = { style = "simple" },
            heading_5 = { style = "simple" },
            heading_6 = { style = "simple" },
          },

          list_items = {
            enable = true,
            shift_width = 2,
            marker_minus = {
              add_padding = false,
              text = "-",
            },
            marker_plus = {
              add_padding = false,
              text = "-",
            },
            marker_star = {
              text = "-",
              add_padding = false,
            },
            marker_dot = {
              add_padding = false,
            },
            marker_parenthesis = {
              add_padding = false,
              conceal_on_checkboxes = true,
            },
          },

          reference_definitions = unify_links({
            "markdown",
            "reference_definitions",
          }, link_hl, link_icon),

          tables = {
            enable = true,
            strict = false,
            block_decorator = true,
            use_virt_lines = true,
          },

          code_blocks = {
            enable = true,
            pad_amount = 0,
            sign = false,
          },

          block_quotes = {
            enable = true,
          },

          horizontal_rules = {
            enable = true,
          },
        },

        markdown_inline = {
          hyperlinks = unify_links({
            "markdown_inline",
            "hyperlinks",
          }, link_hl, link_icon),

          uri_autolinks = unify_links({
            "markdown_inline",
            "uri_autolinks",
          }, link_hl, link_icon),

          internal_links = unify_links({
            "markdown_inline",
            "internal_links",
          }, link_hl, link_icon),

          embed_files = unify_links({
            "markdown_inline",
            "embed_files",
          }, link_hl, link_icon),

          emails = unify_links({
            "markdown_inline",
            "emails",
          }, link_hl, link_icon),

          images = unify_links({
            "markdown_inline",
            "images",
          }, nil, ""),

          block_references = unify_links({
            "markdown_inline",
            "block_references",
          }, link_hl, link_icon),
        },
      }
    end,
  },
}

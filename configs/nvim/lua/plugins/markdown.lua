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

      -- Highlight group used for ALL links
      local link_hl = "MarkviewHyperlink"

      -- Strips icons and enforces a unified highlight
      local function unify_links(path, hl)
        local original = spec.get(path, { fallback = {} })
        local modified = {}
        for pattern, conf in pairs(original) do
          if type(conf) == "table" then
            modified[pattern] = vim.tbl_extend("force", conf, {
              icon = "",
              hl = hl or conf.hl,
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

            heading_1 = { style = "simple", icon = "# " },
            heading_2 = { style = "simple", icon = "## " },
            heading_3 = { style = "simple", icon = "### " },
            heading_4 = { style = "simple", icon = "#### " },
            heading_5 = { style = "simple", icon = "##### " },
            heading_6 = { style = "simple", icon = "###### " },
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

          reference_definitions = unify_links({ "markdown", "reference_definitions" }, link_hl),

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
          hyperlinks = unify_links({ "markdown_inline", "hyperlinks" }, link_hl),
          uri_autolinks = unify_links({ "markdown_inline", "uri_autolinks" }, link_hl),
          images = unify_links({ "markdown_inline", "images" }, nil),
        },
      }
    end,
  },
}

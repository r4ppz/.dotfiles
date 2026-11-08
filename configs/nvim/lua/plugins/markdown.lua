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
    opts = {
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

          heading_1_sign = false,
          heading_2_sign = false,
          heading_3_sign = false,
          heading_4_sign = false,
          heading_5_sign = false,
          heading_6_sign = false,
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

        reference_definitions = {
          enable = true,
        },

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
    },
  },
}

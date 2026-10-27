return {
  "nvim-tree/nvim-tree.lua",
  init = function()
    local prev = { new_name = "", old_name = "" }

    vim.api.nvim_create_autocmd("User", {
      pattern = "NvimTreeSetup",
      callback = function()
        local events = require("nvim-tree.api").events
        events.subscribe(events.Event.NodeRenamed, function(data)
          if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
            prev = data
            Snacks.rename.on_rename_file(data.old_name, data.new_name)
          end
        end)
      end,
    })
  end,

  opts = function()
    return {
      filters = {
        dotfiles = false,
        git_ignored = false,
        custom = {},
      },

      disable_netrw = true,
      hijack_cursor = true,
      sync_root_with_cwd = true,

      update_focused_file = {
        enable = true,
        update_root = false,
      },

      view = {
        width = 40,
        side = "left",
        preserve_window_proportions = true,
      },

      actions = {
        open_file = {
          quit_on_open = true,
        },
      },

      git = {
        enable = true,
        show_on_dirs = true,
      },

      diagnostics = {
        enable = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },

      renderer = {
        group_empty = true,
        root_folder_label = false,
        highlight_git = "none",
        indent_markers = { enable = true },
        icons = {
          git_placement = "after",

          glyphs = {
            default = "󰈚",
          },
        },
      },

      on_attach = function(bufnr)
        local map = vim.keymap.set
        local api = require("nvim-tree.api")

        api.map.on_attach.default(bufnr)

        map("n", "<ESC>", "<nop>", { buffer = bufnr, desc = "fucking nothing" })
        map("n", "<C-S-Up>", api.node.show_info_popup, { buffer = bufnr, desc = "Info" })
        map("n", "]", api.tree.change_root_to_node, { buffer = bufnr, desc = "cd" })
        map("n", "[", api.tree.change_root_to_parent, { buffer = bufnr, desc = "cd .." })
      end,
    }
  end,

  keys = {
    { "<M-e>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
    {
      "<leader>ca",
      function()
        local window = require("utils.window")
        window.close_panels()

        if vim.bo.filetype == "copilot-chat" then
          window.focus_main()
        end

        require("utils.tree_chat").add_to_copilot()
      end,
      desc = "Add file/s to CopilotChat",
    },
  },
}

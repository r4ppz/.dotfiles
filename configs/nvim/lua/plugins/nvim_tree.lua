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

        -- open/expand directory or preview file (like Tab)
        local function open_or_preview()
          local node = api.tree.get_node_under_cursor()
          if not node then
            return
          end

          if node.type == "directory" then
            api.node.open.edit(node)
          else
            api.node.open.preview(node)
          end
        end

        local function collapse_all_except_current()
          local node = api.tree.get_node_under_cursor()
          if not node then
            return
          end

          api.tree.collapse_all()

          api.tree.find_file({
            buf = node.absolute_path,
            focus = true,
          })
        end

        map("n", "w", collapse_all_except_current, {
          buffer = bufnr,
          desc = "Collapse all except current",
        })

        map("n", "h", api.node.navigate.parent_close, {
          buffer = bufnr,
          desc = "Close Directory",
        })
        map("n", "l", open_or_preview, {
          buffer = bufnr,
          desc = "Open Directory or Preview File",
        })

        map("n", "<ESC>", "<nop>", { buffer = bufnr, desc = "fucking nothing" })
        map("n", { "<C-S-Up>", "<leader>k", "<gK>" }, api.node.show_info_popup, {
          buffer = bufnr,
          desc = "Info",
        })
        map("n", "]", api.tree.change_root_to_node, { buffer = bufnr, desc = "cd" })
        map("n", "[", api.tree.change_root_to_parent, { buffer = bufnr, desc = "cd .." })

        map("n", "J", "<C-e>", { buffer = bufnr, desc = "Scroll down" })
        map("n", "K", "<C-y>", { buffer = bufnr, desc = "Scroll up" })
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

        require("utils.chat").add_to_copilot()
      end,
      desc = "Add file/s to CopilotChat",
    },
  },
}

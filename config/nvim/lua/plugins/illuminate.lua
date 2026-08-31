return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("illuminate").configure({
      providers = {
        "lsp",
        "treesitter",
      },
      delay = 200,
      filetypes_denylist = {
        "alpha",
        "dashboard",
        "NvimTree",
        "terminal",
        "lazy",
        "notify",
        "copilot-chat",
        "help",
        "man",
        "DiffviewFiles",
        "DiffviewFileHistory",
        "markdown",
      },
      min_count_to_highlight = 2,
      under_cursor = true,
    })
  end,

  keys = {
    {
      "[r",
      function()
        require("illuminate").goto_prev_reference()
      end,
      mode = { "n", "v" },
      desc = "Prev Reference (vim-illuminate)",
    },
    {
      "]r",
      function()
        require("illuminate").goto_next_reference()
      end,
      mode = { "n", "v" },
      desc = "Next Reference (vim-illuminate)",
    },
  },
}

return {
  "hedyhli/outline.nvim",
  event = "LspAttach",
  config = function()
    require("outline").setup({
      outline_window = {
        width = 30,
        auto_close = false,
        auto_jump = true,
        jump_highlight_duration = 500,
      },

      keymaps = {
        fold = { "<Left>", "h" },
        unfold = { "<Right>", "l" },
        hover_symbol = { "<C-S-Up>", "<leader>k" },
      },
    })
  end,
}

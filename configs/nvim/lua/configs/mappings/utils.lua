local map = vim.keymap.set

--------------------------------------------------------
-- Utils
map("n", "<leader>y", "<CMD>CopyPathAndLine<CR>", { desc = "Copy file path & line number" })
map("v", "<leader>y", "<CMD>CopyPathAndLine<CR>", { desc = "Copy file path & line range" })

map({ "n", "v" }, "<leader>ub", "<cmd>BufInfo<CR>", { desc = "Get BufInfo" })
map({ "n", "v" }, "<leader>uc", "<CMD>OpenConfig<CR>", { desc = "Open Neovim Config" })
map({ "n", "v" }, "<leader>uh", "<cmd>checkhealth<cr>", { desc = "Check Health" })

map({ "n", "v" }, "<leader>uf", function()
  require("conform").format({
    timeout_ms = 1000,
    async = true,
  })
end, { desc = "Format & Autofix File" })

map({ "n", "v" }, "<C-c>", "<cmd>%y+<CR>", { desc = "Copy whole file" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })

--------------------------------------------------------
-- Toggle
map("n", "<leader>tt", "<CMD>ToggleBool<CR>", { desc = "Toggle Boolean" })

map("n", "<leader>tw", function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle line wrapping" })

map("n", "<leader>tm", "<cmd>Markview toggle<CR>", {
  desc = "Toggle markdown rendering (buf)",
})

map("n", "<leader>tn", function()
  vim.wo.number = not vim.wo.number
end, { desc = "Toggle line numbers" })

map("n", "<leader>tr", function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle relative line numbers" })

map("n", "<leader>ts", "<CMD>Markview splitToggle<CR>", {
  desc = "Toggle markdown rendering split",
})

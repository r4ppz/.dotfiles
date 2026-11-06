local mygroup = vim.api.nvim_create_augroup("smh", { clear = true })
local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

autocmd("FileType", {
  group = mygroup,
  desc = "No conceal in gayson cause its annoying",
  pattern = { "json", "jsonc" },
  callback = function()
    vim.opt_local.conceallevel = 0
    vim.opt_local.concealcursor = ""
  end,
})

autocmd("FileType", {
  group = mygroup,
  desc = "I need to enable this for some reason",
  pattern = "tmux",
  callback = function()
    vim.bo.syntax = "tmux"
  end,
})

autocmd("FileType", {
  group = mygroup,
  desc = "Better quickfix and location list configuration",
  pattern = "qf",
  callback = function(args)
    map("n", "q", "<cmd>close<cr>", { buffer = args.buf })
    vim.opt_local.statusline = ""
    vim.opt_local.number = false
  end,
})

autocmd("FileType", {
  group = mygroup,
  desc = "Close window with q",
  pattern = { "help", "gitsigns-blame" },
  callback = function()
    map("n", "q", "<cmd>close<cr>", { buffer = true })
  end,
})

autocmd("TermOpen", {
  group = mygroup,
  desc = "Keep the state of snacks lazygit (toggleble)",
  pattern = "*",
  callback = function()
    local term_title = vim.b.term_title
    if term_title and (term_title:match("lazygit") or term_title:match("lazydocker")) then
      map("t", { "<M-g>", "q" }, "<cmd>close<cr>", { buffer = true })
    end
  end,
})

autocmd({
  "BufEnter",
  "CursorHold",
  "CursorHoldI",
  "FocusGained",
}, {
  group = mygroup,
  desc = "Check for file changes when entering buffer or regaining focus",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

autocmd({ "FileType", "BufEnter" }, {
  group = mygroup,
  pattern = { "copilot-chat" },
  callback = function(args)
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.autocomplete = true
    vim.opt_local.completeopt = { "menu", "menuone", "noselect", "popup" }
    vim.opt_local.pumborder = "single"
    vim.opt_local.complete = ".,w,b,u,t"

    map("i", "<C-l>", "<Right>", {
      buffer = args.buf,
      desc = "Move right",
    })
  end,
})

autocmd("BufReadPost", {
  group = mygroup,
  pattern = { "*.png", "*.jpg", "*.jpeg", "*.webp", "*.gif", "*.bmp", "*.svg" },
  desc = "Open images in imv and close buffer automatically",
  callback = function(args)
    vim.fn.jobstart({ "imv", args.file }, { detach = true })

    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.api.nvim_buf_delete(args.buf, { force = true })
      end
    end)
  end,
})

autocmd("BufReadPost", {
  group = mygroup,
  pattern = { "*.pdf", "*.epub" },
  desc = "Open PDF/EPUB files in Okular and close buffer automatically",
  callback = function(args)
    vim.fn.jobstart({ "okular", args.file }, { detach = true })
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.api.nvim_buf_delete(args.buf, { force = true })
      end
    end)
  end,
})

autocmd("FileType", {
  group = mygroup,
  desc = "Enable wrapping",
  pattern = { "text", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
    vim.opt_local.textwidth = 120
    vim.opt_local.formatoptions:append("t")
  end,
})

autocmd("TextYankPost", {
  group = mygroup,
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.hl.hl_op({
      higroup = "IncSearch",
      timeout = 150,
    })
  end,
})

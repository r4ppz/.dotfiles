local window = require("utils.window")
local map = vim.keymap.set

-- Related to buffer, window, terminal and tabs

---------------------------------------------------------------------
-- Buffer management

map("n", "<leader>n", "<cmd>enew<CR>", { desc = "Buffer new" })

-- change buffer
map(
  { "n", "v" },
  { "<M-Right>", "<M-l>" },
  window.safe_buf_action(function()
    require("nvchad.tabufline").next()
  end),
  { desc = "Buffer goto next" }
)
map(
  { "n", "v" },
  { "<M-Left>", "<M-h>" },
  window.safe_buf_action(function()
    require("nvchad.tabufline").prev()
  end),
  { desc = "Buffer goto prev" }
)

-- move buffer
map(
  { "n", "v" },
  { "<C-M-Right>", "<C-M-l>" },
  window.safe_buf_action(function()
    require("nvchad.tabufline").move_buf(1)
  end),
  { desc = "move buffer to the right" }
)
map(
  { "n", "v" },
  { "<C-M-Left>", "<C-M-h>" },
  window.safe_buf_action(function()
    require("nvchad.tabufline").move_buf(-1)
  end),
  { desc = "move buffer to the left" }
)

-- close buffer
map(
  "n",
  "<M-q>",
  window.safe_buf_action(function()
    require("nvchad.tabufline").close_buffer()
  end),
  { desc = "Buffer close" }
)

map(
  "n",
  "<S-M-Q>",
  window.safe_buf_action(function()
    require("nvchad.tabufline").closeAllBufs(false)
  end),
  { desc = "Close all buffers except current" }
)

---------------------------------------------------------------------
-- Terminal management

local function map_close_terminal(config, extra_key)
  local map_local = vim.keymap.set
  -- Default
  map_local("t", "<M-q>", function()
    require("nvchad.term").toggle(config)
  end, { buffer = 0 })

  -- Optionally add an extra close key
  if extra_key then
    map_local("t", extra_key, function()
      require("nvchad.term").toggle(config)
    end, { buffer = 0 })
  end
end

map({ "n", "i", "v", "t" }, "<M-w>", function()
  local config = {
    pos = "float",
    id = "float_term",
    float_opts = window.center_float(0.7, 0.7),
  }
  require("nvchad.term").toggle(config)
  map_close_terminal(config, "<M-g>")
end, { desc = "Toggle Floating Terminal" })

map({ "n", "i", "v", "t" }, "<M-B>", function()
  local config = {
    pos = "float",
    id = "btop_float",
    float_opts = window.center_float(0.8, 0.8),
    cmd = "btop",
  }
  require("nvchad.term").toggle(config)
  map_close_terminal(config, "q")
end, { desc = "Toggle Btop" })

-- Docker floating terminal
map({ "n", "i", "v", "t" }, "<M-D>", function()
  local system = require("utils.system")
  local cwd = vim.fn.getcwd()

  if not system.is_process_running("dockerd") then
    vim.notify("dockerd is not running", vim.log.levels.WARN)
    return
  end

  if not system.file_exists("docker-compose.yml", cwd) then
    vim.notify("docker-compose.yml doesn't exist in CWD", vim.log.levels.WARN)
  end

  require("utils.lazydocker").open()
end, { desc = "Toggle LazyDocker (Snacks)" })

map({ "n", "i", "v", "t" }, "<M-s>", function()
  local config = {
    pos = "sp",
    id = "horizontal_term",
    size = 0.5,
  }

  window.focus_main()
  require("nvchad.term").toggle(config)

  map_close_terminal(config, "<M-c>")
end, { desc = "Toggle Horizontal Terminal" })

map({ "n", "i", "v", "t" }, "<M-v>", function()
  local config = {
    pos = "vsp",
    id = "vertical_term",
    size = 0.5,
  }

  window.toggle_panel(function()
    window.focus_main()
    require("nvchad.term").toggle(config)
  end, "NvTerm_vsp")

  map_close_terminal(config, "<M-c>")
end, { desc = "Toggle Vertical Terminal" })

map({ "n", "i", "v", "t" }, "<A-t>", function()
  vim.cmd("enew")
  vim.cmd("terminal")
  vim.cmd("startinsert")
end, { desc = "New Terminal Buffer" })

---------------------------------------------------------------------
-- Window related stuff

map({ "n", "v" }, "<C-w><S-Left>", function()
  vim.cmd("wincmd H")
end, { desc = "Move window to the far left" })
map({ "n", "v" }, "<C-w><S-Right>", function()
  vim.cmd("wincmd L")
end, { desc = "Move window to the far left" })
map({ "n", "v" }, "<C-w><S-Down>", function()
  vim.cmd("wincmd J")
end, { desc = "Move window to the far left" })
map({ "n", "v" }, "<C-w><S-Up>", function()
  vim.cmd("wincmd K")
end, { desc = "Move window to the far left" })

map({ "n", "v" }, { "<S-M-Down>", "<M-J>" }, "<CMD>resize +2<CR>", {
  desc = "Increase window height",
})
map({ "n", "v" }, { "<S-M-Up>", "<M-K>" }, "<CMD>resize -2<CR>", {
  desc = "Decrease window height",
})
map({ "n", "v" }, { "<S-M-Right>", "<M-L>" }, "<CMD>vertical resize -2<CR>", {
  desc = "Decrease window width",
})
map({ "n", "v" }, { "<S-M-Left>", "<M-H>" }, "<CMD>vertical resize +2<CR>", {
  desc = "Increase window width",
})

map("n", "<C-S-M-q>", ":only<CR>", {
  desc = "Close all other windows",
})

map("n", "<C-W>q", function()
  require("utils.window").close_safely()
end, { desc = "Close window safely" })

--------------------------------------------------------
-- Tabs shit

map("n", "tn", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "tQ", "<cmd>tabonly<CR>", { desc = "Close all other tabs" })
map("n", "tq", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", { "t<Right>", "tl" }, "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", { "t<Left>", "th" }, "<cmd>tabprevious<CR>", { desc = "Previous tab" })

---------------------------------------------------------------------
-- Random UI popups
map({ "n", "v" }, "<leader>pl", "<cmd>Lazy<CR>", { desc = "Lazy UI" })
map("n", "<leader>vc", "<cmd>NvCheatsheet<CR>", { desc = "Toggle nvcheatsheet" })

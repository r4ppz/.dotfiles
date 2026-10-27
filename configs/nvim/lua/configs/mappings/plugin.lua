local window = require("utils.window")
local map = require("utils.map")

-- Uses plugins? (other keybinds are in the plugin Lua files)

---------------------------------------------------------------------
-- BUFFERS MANAGEMENT

map("n", "<leader>n", "<cmd>enew<CR>", { desc = "Buffer new" })

-- change buffer
map(
  { "i", "n", "v" },
  "<M-Right>",
  window.safe_buf_action(function()
    require("nvchad.tabufline").next()
  end),
  { desc = "Buffer goto next" }
)
map(
  { "i", "n", "v" },
  "<M-Left>",
  window.safe_buf_action(function()
    require("nvchad.tabufline").prev()
  end),
  { desc = "Buffer goto prev" }
)

-- move buffer
map(
  { "i", "n", "v" },
  "<C-M-Right>",
  window.safe_buf_action(function()
    require("nvchad.tabufline").move_buf(1)
  end),
  { desc = "move buffer to the right" }
)
map(
  { "i", "n", "v" },
  "<C-M-Left>",
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
-- NVCHAD

map("n", "<leader>vc", "<cmd>NvCheatsheet<CR>", { desc = "Toggle nvcheatsheet" })

---------------------------------------------------------------------
-- TERMINAL MANAGEMENT

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

map({ "n", "i", "v", "t" }, "<M-b>", function()
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
map({ "n", "i", "v", "t" }, "<M-S-d>", function()
  local system = require("utils.system")
  local cwd = vim.fn.getcwd()

  if not system.is_process_running("dockerd") then
    vim.notify("dockerd is not running", vim.log.levels.WARN)
    return
  end

  if not system.is_file_exists("docker-compose.yml", cwd) then
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

--------------------------------------------------------
-- Utilitys
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

--------------------------------------------------------
-- Toggle
map("n", "<leader>tt", "<CMD>ToggleBool<CR>", { desc = "Toggle Boolean" })

map("n", "<leader>tw", function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle line wrapping" })

map("n", "<leader>tm", function()
  require("render-markdown").toggle()
end, { desc = "Toggle markdown rendering" })

---------------------------------------------------------------------
map({ "n", "v" }, "<leader>pl", "<cmd>Lazy<CR>", { desc = "Lazy UI" })

local M = {}

-- Filetypes that should not be open at the same time
local SIDE_PANEL_FTS = {
  "copilot-chat",
  "Outline",
  "terminal",
  "NvTerm_vsp",
  "grug-far",
  "dapui_console",
  "dap-repl",
  "dapui_watches",
  "dapui_stacks",
  "dapui_breakpoints",
  "dapui_scopes",
  "snacks_terminal",
}

local EXCLUDED_FILETYPES = {
  "copilot-chat",
  "NvimTree",
  "Outline",
  "grug-far",
  "trouble",
  "dapui_console",
  "dap-repl",
  "dapui_watches",
  "dapui_stacks",
  "dapui_breakpoints",
  "dapui_scopes",
}

local EXCLUDED_BUFTYPES = {
  "nofile",
  "prompt",
  "help",
  "quickfix",
  "terminal",
}

--- Checks if a window and buffer is a main editing window.
local function is_main(win, buf)
  if not M.is_standard(win) then
    return false
  end

  if M.is_bt_excluded(buf, EXCLUDED_BUFTYPES) then
    return false
  end

  if M.is_ft_excluded(buf, EXCLUDED_FILETYPES) then
    return false
  end

  return true
end

--- Checks if a given window is a standard window.
function M.is_standard(win)
  local win_config = vim.api.nvim_win_get_config(win)
  return win_config.relative == "" and not win_config.external
end

--- `true` if the filetype matches any exclusion, `false` otherwise.
function M.is_ft_excluded(buf, exclude_filetypes)
  if not vim.api.nvim_buf_is_valid(buf) then
    return false
  end

  local ft = vim.bo[buf].filetype or ""
  if ft == "" then
    return false
  end

  return vim.tbl_contains(exclude_filetypes, ft)
end

--- Determines if a buffer's buftype matches any in the exclusion list.
function M.is_bt_excluded(buf, exclude_buftypes)
  if not vim.api.nvim_buf_is_valid(buf) then
    return false
  end

  local bt = vim.bo[buf].buftype or ""
  if bt == "" then
    return false
  end

  return vim.tbl_contains(exclude_buftypes, bt)
end

--- true if both the buffer and window are valid, false otherwise.
function M.is_buf_win_valid(buf, win)
  return vim.api.nvim_buf_is_valid(buf)
    and vim.api.nvim_win_is_valid(win)
    and vim.fn.win_gettype(win) == ""
    and vim.bo[buf].buftype == ""
    and not vim.wo[win].diff
end

--- `true` if the buffer is an empty scratch buffer.
function M.is_empty_scratch_buf(buf)
  return vim.api.nvim_buf_get_name(buf) == "" and vim.bo[buf].buftype == ""
end

--- Take and return a func, ensure func only runs on standard buf
function M.safe_buf_action(action)
  return function()
    if not M.is_standard(0) then
      return
    end

    if M.is_ft_excluded(0, EXCLUDED_FILETYPES) then
      return
    end

    pcall(action)
  end
end

--- Focuses the main window in the current tabpage.
function M.focus_main()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_get_current_buf()

  if is_main(current_win, current_buf) then
    return
  end

  local windows = vim.api.nvim_tabpage_list_wins(0)
  for _, window in ipairs(windows) do
    local buffer = vim.api.nvim_win_get_buf(window)
    if is_main(window, buffer) then
      vim.api.nvim_set_current_win(window)
      return
    end
  end
end

--- Closes all side panel windows in the current tabpage.
function M.close_panels()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)

    if M.is_ft_excluded(buf, SIDE_PANEL_FTS) then
      vim.api.nvim_win_close(win, true)
    end
  end
end

--- Closes other side panels (if target is not already open) then runs the toggle.
function M.toggle_panel(toggle_fn, panel_ft)
  local already_open = false
  local windows = vim.api.nvim_tabpage_list_wins(0)
  for _, window in ipairs(windows) do
    local buffer = vim.api.nvim_win_get_buf(window)
    if vim.bo[buffer].filetype == panel_ft then
      already_open = true
      break
    end
  end

  if not already_open then
    M.close_panels()
  end

  toggle_fn()
end

--- Prevents closing the last standard window in the last tabpage,
function M.close_safely()
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_win_get_buf(win)

  if not is_main(win, buf) then
    vim.cmd("q")
    return
  end

  local normal_wins = 0
  for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local b = vim.api.nvim_win_get_buf(w)
    if is_main(w, b) then
      normal_wins = normal_wins + 1
    end
  end

  local total_tabs = #vim.api.nvim_list_tabpages()

  if normal_wins > 1 or total_tabs > 1 then
    vim.cmd("q")
  else
    vim.notify("Cannot close the last window", vim.log.levels.WARN)
  end
end

--- Center floating window opt relative to editor
function M.center_float(width_frac, height_frac)
  local border_size = 1
  local total_border = 2 * border_size
  local editor_width = vim.o.columns
  local editor_height = vim.o.lines

  local outer_width = math.floor(editor_width * width_frac)
  local outer_height = math.floor(editor_height * height_frac)

  local content_width = outer_width - total_border
  local content_height = outer_height - total_border

  local col = math.floor((editor_width - outer_width) / 2)
  local row = math.floor((editor_height - outer_height) / 2)

  -- Offset by 0.5 to compensate for create_float's ceil(frac * size) in nvui.
  return {
    relative = "editor",
    border = "single",
    width = (content_width - 0.5) / editor_width,
    height = (content_height - 0.5) / editor_height,
    col = (col - 0.5) / editor_width,
    row = (row - 0.5) / editor_height,
  }
end

--- Minimal cursor-relative floating input
function M.floating_input(opts, on_confirm)
  opts = opts or {}
  local prompt = opts.prompt or "Rename: "
  local default_text = opts.default or ""
  local width = #prompt + #default_text + 5

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.b[buf].completion = false

  local win_opts = {
    relative = "cursor",
    row = 1,
    col = 0,
    width = width,
    height = 1,
    style = "minimal",
    border = "single",
    title = " " .. prompt,
    title_pos = "left",
  }

  local win = vim.api.nvim_open_win(buf, true, win_opts)
  vim.wo[win].winhighlight = "FloatTitle:Normal"

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { default_text })

  local closed = false
  local function close(result)
    if closed then
      return
    end
    closed = true

    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    vim.cmd("stopinsert")
    on_confirm(result)
  end

  -- Confirm on <CR> from either Insert or Normal mode
  vim.keymap.set({ "i", "n" }, "<CR>", function()
    local line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
    close(line and line ~= "" and line or nil)
  end, { buffer = buf, silent = true, nowait = true })

  -- Cancel ONLY on 'q' in Normal mode
  vim.keymap.set("n", "q", function()
    close(nil)
  end, { buffer = buf, silent = true, nowait = true })

  -- Cancel if user clicks away or switches window
  vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
    buffer = buf,
    once = true,
    callback = function()
      close(nil)
    end,
  })

  -- Start in Normal mode with cursor on the first character
  vim.cmd("stopinsert")
  vim.api.nvim_win_set_cursor(win, { 1, 0 })
end

--- Triggers LSP rename using M.floating_input without altering global vim.ui.input.
function M.lsp_rename()
  local clients = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/rename" })
  if #clients == 0 then
    vim.notify("No LSP client with rename capability attached", vim.log.levels.WARN)
    return
  end

  local orig_input = vim.ui.input

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.input = function(opts, on_confirm)
    vim.ui.input = orig_input
    M.floating_input(opts, on_confirm)
  end

  -- Safety cleanup in case prepareRename fails or server hangs
  vim.defer_fn(function()
    if vim.ui.input ~= orig_input then
      vim.ui.input = orig_input
    end
  end, 1500)

  vim.lsp.buf.rename()
end

return M

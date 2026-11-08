local chat = require("CopilotChat")
local prompts = require("configs.llm.prompts")
local window = require("utils.window")
local snacks = require("snacks")

local M = {}

local function add_files_to_chat(files)
  if #files == 0 then
    vim.notify("No valid files to add", vim.log.levels.WARN)
    return
  end

  local cwd = vim.fn.getcwd()
  local lines = {}
  for _, file in ipairs(files) do
    local path = vim.startswith(file, cwd) and vim.fn.fnamemodify(file, ":.") or file
    table.insert(lines, "#file:" .. path)
  end

  chat.open()
  vim.schedule(function()
    vim.api.nvim_put(lines, "l", true, true)
    vim.cmd("normal! G")
  end)
end

local function collect_files_from_directory(dir)
  local all = vim.fn.globpath(dir, "**/*", false, true)
  local files = {}
  for _, item in ipairs(all) do
    if vim.fn.isdirectory(item) == 0 and vim.fn.filereadable(item) == 1 then
      table.insert(files, item)
    end
  end
  return files
end

local function node_to_files(node)
  if node.absolute_path and vim.fn.isdirectory(node.absolute_path) == 1 then
    return collect_files_from_directory(node.absolute_path)
  else
    return { node.absolute_path }
  end
end

function M.add_to_copilot()
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.bo[bufnr].filetype
  local files = {}

  if ft == "NvimTree" then
    local api = require("nvim-tree.api")
    local marked = api.marks.list()

    if #marked > 0 then
      for _, node in ipairs(marked) do
        vim.list_extend(files, node_to_files(node))
      end
      api.marks.clear()
    else
      local node = api.tree.get_node_under_cursor()
      if node then
        vim.list_extend(files, node_to_files(node))
      end
    end
    api.tree.close()
  else
    local file = vim.api.nvim_buf_get_name(bufnr)
    if file ~= "" and vim.fn.filereadable(file) == 1 then
      files = { file }
    else
      vim.notify("Current buffer is not a valid file", vim.log.levels.WARN)
      return
    end
  end

  add_files_to_chat(files)
end

function M.pick_file()
  window.close_panels()
  snacks.picker.files({
    confirm = function(picker, item)
      local items = picker:selected()
      if #items == 0 then
        items = { item }
      end

      picker:close()

      local lines = {}
      for _, sel in ipairs(items) do
        local path = vim.fn.fnamemodify(sel.file, ":.")
        table.insert(lines, "#file:" .. path)
      end

      chat.open()

      vim.schedule(function()
        vim.api.nvim_put(lines, "l", true, true)
        vim.cmd("normal! G")
      end)
    end,
  })
end

function M.better_hover()
  window.close_panels()
  local params = vim.lsp.util.make_position_params(nil, "utf-16")
  local responses = vim.lsp.buf_request_sync(0, "textDocument/hover", params, 500)

  if not responses or vim.tbl_isempty(responses) then
    vim.notify("No hover information available", vim.log.levels.WARN)
    return
  end

  local parts = {}
  for _, resp in pairs(responses) do
    if resp and resp.result and resp.result.contents then
      local md = vim.lsp.util.convert_input_to_markdown_lines(resp.result.contents) or {}
      for _, line in ipairs(md) do
        if line and line ~= "" then
          parts[#parts + 1] = line
        end
      end
    end
  end

  if #parts == 0 then
    vim.notify("No hover text found", vim.log.levels.WARN)
    return
  end

  local hover_text = table.concat(parts, "\n")

  chat.open()
  chat.ask(
    prompts.prompts.BetterDocs.prompt .. "\n\n" .. hover_text,
    { clear_chat_on_new_prompt = true }
  )
end

return M

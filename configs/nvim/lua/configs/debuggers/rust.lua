local M = {}

local cargo = require("utils.cargo")

local function rust_init_commands()
  local ok, out = pcall(vim.fn.system, { "rustc", "--print", "sysroot" })
  if not ok then
    return {}
  end

  local lookup = vim.fs.joinpath(vim.trim(out), "lib", "rustlib", "etc", "lldb_lookup.py")
  if vim.fn.filereadable(lookup) ~= 1 then
    return {}
  end

  return { ("!command script import '%s'"):format(lookup) }
end

-- rustc ships LLDB pretty-printers at <sysroot>/lib/rustlib/etc/lldb_lookup.py.
local rust_commands = rust_init_commands()

function M.setup(dap)
  -- Must be absolute: lldb-dap re-execs itself via runInTerminal from the session cwd.
  local lldb_dap = vim.fn.exepath("lldb-dap")

  dap.adapters.lldb = {
    type = "executable",
    command = lldb_dap ~= "" and lldb_dap or "lldb-dap",
    name = "lldb",
  }

  local function launch(name, console)
    return {
      name = name,
      type = "lldb",
      request = "launch",
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      console = console,
      initCommands = rust_commands,
      program = function()
        if not cargo.build() then
          return dap.ABORT
        end
        return cargo.find_bin() or dap.ABORT
      end,
    }
  end

  dap.configurations.rust = {
    -- pty, so stdin and TUI programs work
    launch("Launch", "integratedTerminal"),
    launch("Launch (output in REPL)", "internalConsole"),
  }
end

return M

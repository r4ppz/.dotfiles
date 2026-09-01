local M = {}

function M.setup(dap)
  dap.adapters["local-lua"] = {
    type = "executable",
    command = "node",
    args = {
      (os.getenv("HOME") .. "/.local/share/nvim/lazy/lazy.nvim")
        .. "/local-lua-debugger-vscode/extension/debugAdapter.js",
    },
  }

  dap.adapters.nlua = function(callback, config)
    callback({
      type = "server",
      host = config.host or "127.0.0.1",
      port = config.port or 8086,
    })
  end

  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
    },
    {
      name = "Debug Current File",
      type = "local-lua",
      request = "launch",
      cwd = "${workspaceFolder}",
      program = {
        lua = "luajit",
        file = "${file}",
      },
      args = {},
      stopOnEntry = false,
    },
  }
end

return M

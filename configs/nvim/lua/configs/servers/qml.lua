local M = {}

function M.setup(capabilities)
  vim.lsp.config("qmlls", {
    capabilities = capabilities,
    cmd = { "qmlls", "-E" },
    filetypes = { "qml" },
    on_attach = function(client, _)
      client.server_capabilities.semanticTokensProvider = nil
    end,
  })
end

return M

local M = {}

function M.setup(capabilities)
  vim.lsp.config("bashls", {
    capabilities = capabilities,
    filetypes = { "bash", "sh" },
  })
end

return M

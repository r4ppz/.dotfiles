local M = {}

function M.setup(capabilities)
  vim.lsp.config("dockerls", {
    capabilities = capabilities,
    root_markers = {
      "Dockerfile",
      "dockerfile",
    },
    filetypes = { "dockerfile" },
  })
end

return M

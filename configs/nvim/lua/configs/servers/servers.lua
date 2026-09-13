local M = {}

local ok, nix_servers = pcall(dofile, vim.fn.stdpath("data") .. "/nix-servers.lua")
M.lsp_list = ok and nix_servers or {}

function M.setup(capabilities)
  vim.filetype.add({
    pattern = {
      ["docker%-compose%.ya?ml"] = "yaml.docker-compose",
      ["compose%.ya?ml"] = "yaml.docker.compose",
      [".*gitlab%-ci%.ya?ml"] = "yaml.gitlab",
      [".*values%.ya?ml"] = "yaml.helm-values",
      [".*/waybar/.*%.css"] = "gtkcss",
    },

    extension = {
      tmpl = "gotmpl",
      gotmpl = "gotmpl",
      xsl = "xsl",
      mdx = "markdown.mdx",
    },
  })

  local config_dir = vim.fn.stdpath("config") .. "/lua/configs/servers"
  if vim.fn.isdirectory(config_dir) ~= 1 then
    return
  end

  local files = vim.fn.readdir(config_dir)
  for _, f in ipairs(files) do
    if f:match("%.lua$") and f ~= "servers.lua" then
      local modname = f:gsub("%.lua$", "")
      local mod = require("configs.servers." .. modname)
      mod.setup(capabilities)
    end
  end
end

return M

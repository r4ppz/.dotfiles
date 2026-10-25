local M = {}

function M.get_current()
  return hl.get_active_workspace().tiled_layout
end

return M

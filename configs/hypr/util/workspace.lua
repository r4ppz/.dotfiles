local M = {}

function M.get_layout()
  return hl.get_active_workspace().tiled_layout
end

function M.has_floating_windows()
  local workspaces = hl.get_active_workspace()
  if not workspaces then
    return false
  end
  local windows = hl.get_workspace_windows(workspaces.id)
  if not windows then
    return false
  end
  for _, win in ipairs(windows) do
    if win.floating then
      return true
    end
  end

  return false
end

return M

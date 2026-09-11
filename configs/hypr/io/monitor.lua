local M = {}

M.internal = "eDP-1"
M.external = "HDMI-A-1"

M.specs = {
  [M.external] = {
    mode = "1920x1080@100",
    scale = 1,
    position = "0x0",
  },
  [M.internal] = {
    mode = "1366x768@60",
    scale = 1,
    position = "1920x0",
  },
}

M.isExternalConnected = function()
  return hl.get_monitor(M.external) ~= nil
end

local function applyMonitors(connected)
  if connected then
    hl.monitor({
      output = M.external,
      mode = M.specs[M.external].mode,
      position = M.specs[M.external].position,
      scale = M.specs[M.external].scale,
    })
    hl.monitor({
      output = M.internal,
      mode = M.specs[M.internal].mode,
      position = M.specs[M.internal].position,
      scale = M.specs[M.internal].scale,
    })
  else
    hl.monitor({
      output = M.internal,
      mode = M.specs[M.internal].mode,
      position = M.specs[M.internal].position,
      scale = M.specs[M.internal].scale,
    })
    hl.monitor({
      output = "",
      mode = "preferred",
      position = "auto",
      scale = 1,
    })
  end
end

local function applyWorkspaces(connected)
  if connected then
    for i = 1, 9 do
      hl.workspace_rule({
        workspace = tostring(i),
        monitor = M.external,
        default = (i == 1),
      })
    end
    hl.workspace_rule({
      workspace = "10",
      monitor = M.internal,
      default = true,
    })
  else
    for i = 1, 10 do
      hl.workspace_rule({
        workspace = tostring(i),
        monitor = M.internal,
        default = (i == 1),
      })
    end
  end
end

local function syncLayout()
  local connected = M.isExternalConnected()
  applyMonitors(connected)
  applyWorkspaces(connected)
end

syncLayout()

hl.on("hyprland.start", syncLayout)

hl.on("monitor.added", function(m)
  if m.name == M.external then
    syncLayout()
    hl.exec_cmd("hyprctl reload")
  end
end)
hl.on("monitor.removed", function(m)
  if m.name == M.external then
    syncLayout()
    hl.exec_cmd("hyprctl reload")
  end
end)

return M

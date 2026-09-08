local displays = require("io.displays")

local function isExternalConnected()
  return hl.get_monitor(displays.external) ~= nil
end

local function applyMonitors(connected)
  if connected then
    hl.monitor({
      output = displays.external,
      mode = displays.specs[displays.external].mode,
      position = "0x0",
      scale = displays.specs[displays.external].scale,
    })
    hl.monitor({
      output = displays.internal,
      mode = displays.specs[displays.internal].mode,
      position = "1920x0",
      scale = displays.specs[displays.internal].scale,
    })
  else
    hl.monitor({
      output = displays.internal,
      mode = displays.specs[displays.internal].mode,
      position = "0x0",
      scale = displays.specs[displays.internal].scale,
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
        monitor = displays.external,
        default = (i == 1),
      })
    end
    hl.workspace_rule({
      workspace = "10",
      monitor = displays.internal,
      default = true,
    })
  else
    for i = 1, 10 do
      hl.workspace_rule({
        workspace = tostring(i),
        monitor = displays.internal,
        default = (i == 1),
      })
    end
  end
end

local function syncLayout()
  local connected = isExternalConnected()
  applyMonitors(connected)
  applyWorkspaces(connected)
end

syncLayout()

hl.on("hyprland.start", syncLayout)
hl.on("monitor.added", function(m)
  if m.name == displays.external then
    syncLayout()
  end
end)
hl.on("monitor.removed", function(m)
  if m.name == displays.external then
    syncLayout()
  end
end)

local monitor = require("system.monitor")

hl.on("hyprland.start", function()
  monitor.apply_config()

  hl.exec_cmd("warp-cli connect")
end)

hl.on("hyprland.shutdown", function()
  -- absolutely nothing
end)

hl.on("monitor.added", function(m)
  if m.name == monitor.external then
    monitor.apply_config()
  end
end)

hl.on("monitor.removed", function(m)
  if m.name == monitor.external then
    monitor.apply_config()
  end
end)

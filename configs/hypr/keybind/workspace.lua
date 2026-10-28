local const = require("util.constant")
local monitor = require("system.monitor")

-- Switch focus between monitors
hl.bind(const.mod .. " + BRACKETLEFT", hl.dsp.focus({ monitor = monitor.external }))
hl.bind(const.mod .. " + BRACKETRIGHT", hl.dsp.focus({ monitor = monitor.internal }))

-- Go to previous workspace
hl.bind(const.mod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Workspace navigation
hl.bind("Page_Up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("Page_Down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(const.mod .. "+ COMMA", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(const.mod .. "+ PERIOD", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(const.mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(const.mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

-- Switch workspaces with vars.mainMod + [0-9]
for i = 1, 10 do
  local key = i % 10
  hl.bind(const.mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(const.mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- -----------------------------------------------------------
-- Special workspace (scratchpad)
-- -----------------------------------------------------------

hl.workspace_rule({
  monitor = hl.get_monitor(monitor.external) and monitor.external or monitor.internal,
  workspace = "special:window2",
  gaps_in = 3,
  gaps_out = {
    top = 180,
    bottom = 180,
    right = 350,
    left = 350,
  },
  layout = "dwindle",
})

hl.bind(const.mod .. " + BACKSLASH", hl.dsp.workspace.toggle_special("window2"))
hl.bind(const.mod .. " + SHIFT + BACKSLASH", hl.dsp.window.move({ workspace = "special:window2" }))

hl.workspace_rule({
  monitor = hl.get_monitor(monitor.external) and monitor.external or monitor.internal,
  workspace = "special:window1",
  gaps_in = 3,
  gaps_out = {
    top = 180,
    right = 350,
    bottom = 180,
    left = 350,
  },
})

hl.bind(const.mod .. " + W", hl.dsp.workspace.toggle_special("window1"))
hl.bind(const.mod .. " + SHIFT + W", hl.dsp.window.move({ workspace = "special:window1" }))

-- Minimize workspace
hl.workspace_rule({
  monitor = hl.get_monitor(monitor.external) and monitor.external or monitor.internal,
  workspace = "special:minimize",
  gaps_in = 2,
  gaps_out = {
    top = 5,
    right = 5,
    bottom = 5,
    left = 5,
  },
  border_size = 0,
  layout = "dwindle",
})

hl.bind(const.mod .. " + grave", hl.dsp.workspace.toggle_special("minimize"))
hl.bind(const.mod .. " + X", hl.dsp.window.move({ workspace = "special:minimize" }))

hl.workspace_rule({
  workspace = "3",
  layout = "scrolling",
})

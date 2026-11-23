local const = require("util.constant")
local monitor = require("system.monitor")
local workspace = require("util.workspace")
local bind = require("util.bind")

-- Switch focus between monitors
bind(const.mod .. " + BRACKETLEFT", hl.dsp.focus({ monitor = monitor.external }))
bind(const.mod .. " + BRACKETRIGHT", hl.dsp.focus({ monitor = monitor.internal }))

-- Go to previous workspace
bind(const.mod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Workspace navigation
bind({
  "Page_Up",
  const.mod .. "+ COMMA",
  const.mod .. " + mouse_up",
}, hl.dsp.focus({ workspace = "e-1" }))

bind({
  "Page_Down",
  const.mod .. "+ PERIOD",
  const.mod .. " + mouse_down",
}, hl.dsp.focus({ workspace = "e+1" }))

-- Switch workspaces
for i = 1, 10 do
  local key = i % 10
  bind(const.mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  bind(const.mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Close active workspace
bind(const.mod .. " + ESCAPE", function()
  workspace.close_active_special()
end)

-- -----------------------------------------------------------
-- Workspace rules
-- -----------------------------------------------------------

hl.workspace_rule({
  workspace = "3",
  layout = "scrolling",
})

-- Special workspaces

hl.workspace_rule({
  monitor = hl.get_monitor(monitor.external) and monitor.external or monitor.internal,
  workspace = "special:window2",
  gaps_in = 3,
  gaps_out = {
    top = 200,
    bottom = 200,
    right = 390,
    left = 390,
  },
  layout = "dwindle",
})

bind(const.mod .. " + BACKSLASH", hl.dsp.workspace.toggle_special("window2"))
bind(const.mod .. " + SHIFT + BACKSLASH", hl.dsp.window.move({ workspace = "special:window2" }))

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

bind(const.mod .. " + W", hl.dsp.workspace.toggle_special("window1"))
bind(const.mod .. " + SHIFT + W", hl.dsp.window.move({ workspace = "special:window1" }))

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

bind(const.mod .. " + grave", hl.dsp.workspace.toggle_special("minimize"))
bind(const.mod .. " + X", hl.dsp.window.move({ workspace = "special:minimize" }))

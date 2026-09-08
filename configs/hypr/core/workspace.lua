local var = require("util.variable")

-- Go to previous workspace
hl.bind(var.mod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))

hl.bind(var.mod .. " + COMMA", hl.dsp.focus({ monitor = "HDMI-A-1" }))
hl.bind(var.mod .. " + PERIOD", hl.dsp.focus({ monitor = "eDP-1" }))

-- Page up/down for workspace navigation
hl.bind("Page_Up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("Page_Down", hl.dsp.focus({ workspace = "e+1" }))

-- Scroll through workspaces with mouse wheel
hl.bind(var.mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(var.mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

-- Switch workspaces with vars.mainMod + [0-9]
for i = 1, 10 do
  local key = i % 10
  hl.bind(var.mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(var.mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Default Workspace 1 on External Monitor
hl.workspace_rule({
  workspace = "1",
  monitor = "HDMI-A-1",
  default = true,
})

-- Workspaces 2 to 9 on External Monitor
for i = 2, 9 do
  hl.workspace_rule({
    workspace = tostring(i),
    monitor = "HDMI-A-1",
  })
end

-- Default Workspace 10 on Laptop Screen
hl.workspace_rule({
  workspace = "10",
  monitor = "eDP-1",
  default = true,
})

-- -----------------------------------------------------------
-- Special workspace (scratchpad)
-- -----------------------------------------------------------

hl.workspace_rule({
  monitor = "HDMI-A-1",
  workspace = "special:window2",
  gaps_in = 3,
  gaps_out = { top = 180, right = 350, bottom = 180, left = 350 },
})

hl.bind(var.mod .. " + BACKSLASH", hl.dsp.workspace.toggle_special("window2"))
hl.bind(var.mod .. " + SHIFT + BACKSLASH", hl.dsp.window.move({ workspace = "special:window2" }))

hl.workspace_rule({
  monitor = "HDMI-A-1",
  workspace = "special:window1",
  gaps_in = 3,
  gaps_out = { top = 180, right = 350, bottom = 180, left = 350 },
})

hl.bind(var.mod .. " + W", hl.dsp.workspace.toggle_special("window1"))
hl.bind(var.mod .. " + SHIFT + W", hl.dsp.window.move({ workspace = "special:window1" }))

-- Minimize workspace
hl.workspace_rule({
  monitor = "HDMI-A-1",
  workspace = "special:minimize",
  gaps_in = 2,
  gaps_out = { top = 5, right = 5, bottom = 5, left = 5 },
  border_size = 0,
})

hl.bind(var.mod .. " + grave", hl.dsp.workspace.toggle_special("minimize"))
hl.bind(var.mod .. " + X", hl.dsp.window.move({ workspace = "special:minimize" }))

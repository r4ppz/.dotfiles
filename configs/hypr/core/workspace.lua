local var = require("util.constants")
local monitors = require("io.monitors")

-- Go to previous workspace
hl.bind(var.mod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))

hl.bind(var.mod .. " + COMMA", hl.dsp.focus({ monitor = monitors.external }))
hl.bind(var.mod .. " + PERIOD", hl.dsp.focus({ monitor = monitors.internal }))

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

-- -----------------------------------------------------------
-- Special workspace (scratchpad)
-- -----------------------------------------------------------

hl.workspace_rule({
  monitor = monitors.external,
  workspace = "special:window2",
  gaps_in = 3,
  gaps_out = { top = 180, right = 350, bottom = 180, left = 350 },
})

hl.bind(var.mod .. " + BACKSLASH", hl.dsp.workspace.toggle_special("window2"))
hl.bind(var.mod .. " + SHIFT + BACKSLASH", hl.dsp.window.move({ workspace = "special:window2" }))

hl.workspace_rule({
  monitor = monitors.external,
  workspace = "special:window1",
  gaps_in = 3,
  gaps_out = { top = 180, right = 350, bottom = 180, left = 350 },
})

hl.bind(var.mod .. " + W", hl.dsp.workspace.toggle_special("window1"))
hl.bind(var.mod .. " + SHIFT + W", hl.dsp.window.move({ workspace = "special:window1" }))

-- Minimize workspace
hl.workspace_rule({
  monitor = monitors.external,
  workspace = "special:minimize",
  gaps_in = 2,
  gaps_out = { top = 5, right = 5, bottom = 5, left = 5 },
  border_size = 0,
})

hl.bind(var.mod .. " + grave", hl.dsp.workspace.toggle_special("minimize"))
hl.bind(var.mod .. " + X", hl.dsp.window.move({ workspace = "special:minimize" }))

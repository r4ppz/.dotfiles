local const = require("util.constant")
local tiling = require("appearance.tiling")

hl.bind(const.mod .. " + SHIFT + K", hl.dsp.window.kill())
hl.bind(const.mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(const.mod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))

hl.bind(const.mod .. " + SHIFT + P", function()
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
  hl.dispatch(hl.dsp.window.pin())
end)

hl.bind("ALT + TAB", function()
  if tiling.has_floating_windows() then
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
  end
end)

-- Focus previous window and bring to top
hl.bind("CTRL + SHIFT + TAB", function()
  if tiling.has_floating_windows() then
    hl.dispatch(hl.dsp.window.cycle_next({ next = false }))
    hl.dispatch(hl.dsp.window.bring_to_top())
  end
end)

-- Center floating window
hl.bind(const.mod .. " + C", hl.dsp.window.center())

-- Fullscreen
hl.bind(const.mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(
  const.mod .. " + SHIFT + F",
  hl.dsp.window.fullscreen_state({
    internal = 0,
    client = 2,
    action = "toggle",
  })
)

-- Move focus with arrow keys
hl.bind(const.mod .. " + LEFT", hl.dsp.focus({ direction = "l" }))
hl.bind(const.mod .. " + RIGHT", hl.dsp.focus({ direction = "r" }))
hl.bind(const.mod .. " + UP", hl.dsp.focus({ direction = "u" }))
hl.bind(const.mod .. " + DOWN", hl.dsp.focus({ direction = "d" }))

-- Move windows with arrow keys
hl.bind(const.mod .. " + SHIFT + LEFT", hl.dsp.window.move({ direction = "l" }))
hl.bind(const.mod .. " + SHIFT + RIGHT", hl.dsp.window.move({ direction = "r" }))
hl.bind(const.mod .. " + SHIFT + UP", hl.dsp.window.move({ direction = "u" }))
hl.bind(const.mod .. " + SHIFT + DOWN", hl.dsp.window.move({ direction = "d" }))

-- Move floating windows
hl.bind(const.mod .. " + CTRL + LEFT", hl.dsp.window.move({ direction = "l" }), { repeating = true })
hl.bind(const.mod .. " + CTRL + RIGHT", hl.dsp.window.move({ direction = "r" }), { repeating = true })
hl.bind(const.mod .. " + CTRL + UP", hl.dsp.window.move({ direction = "u" }), { repeating = true })
hl.bind(const.mod .. " + CTRL + DOWN", hl.dsp.window.move({ direction = "d" }), { repeating = true })

-- Mouse window movement and resizing
hl.bind(const.mod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(const.mod .. " + mouse:273", hl.dsp.window.resize())

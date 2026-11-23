local const = require("util.constant")
local workspace = require("util.workspace")
local bind = require("util.bind")

bind(const.mod .. " + SHIFT + Q", hl.dsp.window.close())
bind(const.mod .. " + SHIFT + CTRL + Q", hl.dsp.window.kill())
bind(const.mod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))

bind(const.mod .. " + SHIFT + P", function()
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
  hl.dispatch(hl.dsp.window.pin())
end)

-- Focus previous window and bring to top
bind("ALT + TAB", function()
  if workspace.has_floating_windows() then
    hl.dispatch(hl.dsp.window.cycle_next({
      next = true,
    }))
    hl.dispatch(hl.dsp.window.bring_to_top())
  elseif workspace.get_layout() == "master" then
    hl.dispatch(hl.dsp.layout("rollnext"))
  end
end)

bind("ALT + SHIFT + TAB", function()
  if workspace.has_floating_windows() then
    hl.dispatch(hl.dsp.window.cycle_next({
      next = false,
    }))
    hl.dispatch(hl.dsp.window.bring_to_top())
  elseif workspace.get_layout() == "master" then
    hl.dispatch(hl.dsp.layout("rollprev"))
  end
end)

-- Center floating window
bind(const.mod .. " + SHIFT + C", hl.dsp.window.center())

-- Fullscreen
bind(const.mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
bind(
  const.mod .. " + SHIFT + F",
  hl.dsp.window.fullscreen_state({
    internal = 0,
    client = 2,
    action = "toggle",
  })
)

-- Move focus with arrow keys
bind({
  const.mod .. " + LEFT",
  const.mod .. " + H",
}, hl.dsp.focus({ direction = "l" }))

bind({
  const.mod .. " + RIGHT",
  const.mod .. " + L",
}, hl.dsp.focus({ direction = "r" }))

bind({
  const.mod .. " + UP",
  const.mod .. " + K",
}, hl.dsp.focus({ direction = "u" }))

bind({
  const.mod .. " + DOWN",
  const.mod .. " + J",
}, hl.dsp.focus({ direction = "d" }))

-- Move windows with arrow keys
bind({
  const.mod .. " + SHIFT + LEFT",
  const.mod .. " + SHIFT + H",
}, hl.dsp.window.move({ direction = "l" }))

bind({
  const.mod .. " + SHIFT + RIGHT",
  const.mod .. " + SHIFT + L",
}, hl.dsp.window.move({ direction = "r" }))

bind({
  const.mod .. " + SHIFT + UP",
  const.mod .. " + SHIFT + K",
}, hl.dsp.window.move({ direction = "u" }))

bind({
  const.mod .. " + SHIFT + DOWN",
  const.mod .. " + SHIFT + J",
}, hl.dsp.window.move({ direction = "d" }))

-- Move floating windows
bind({
  const.mod .. " + CTRL + LEFT",
  const.mod .. " + CTRL + H",
}, hl.dsp.window.move({ direction = "l" }), { repeating = true })

bind({
  const.mod .. " + CTRL + RIGHT",
  const.mod .. " + CTRL + L",
}, hl.dsp.window.move({ direction = "r" }), { repeating = true })

bind({
  const.mod .. " + CTRL + UP",
  const.mod .. " + CTRL + K",
}, hl.dsp.window.move({ direction = "u" }), { repeating = true })

bind({
  const.mod .. " + CTRL + DOWN",
  const.mod .. " + CTRL + J",
}, hl.dsp.window.move({ direction = "d" }), { repeating = true })

-- Mouse window movement and resizing
bind(const.mod .. " + mouse:272", hl.dsp.window.drag())
bind(const.mod .. " + mouse:273", hl.dsp.window.resize())

local notify = require("util.notify")
local process = require("util.process")

local M = {}

local state = "released"

--- Mouse click
function M.click(button)
  if button == "left" then
    process.run("ydotool click 0x40 0x80")
    hl.dispatch(hl.dsp.submap("reset"))
  elseif button == "right" then
    process.run("ydotool click 0x41 0x81")
  elseif button == "middle" then
    process.run("ydotool click 0x42 0x82")
  end
end

-- Toggle press/release + copy
function M.toggle()
  if state == "released" then
    state = "pressed"
    process.run("ydotool click 0x40")
  else
    state = "released"
    process.run("ydotool click 0x80")

    hl.timer(function()
      process.run("ydotool key 29:1 46:1 46:0 29:0") -- Ctrl+C
      process.run("ydotool click 0x40 0x80") -- clear selection

      notify.send("Copied", nil, {
        timeout = 1400,
        app_name = "Mouse Mode",
        icon = "dialog-information",
        transient = true,
      })

      hl.dispatch(hl.dsp.submap("reset"))
    end, { timeout = 100, type = "oneshot" })
  end
end

function M.reset()
  state = "released"
  process.run("ydotool click 0x80")
  hl.dispatch(hl.dsp.submap("reset"))
end

--- Moves the mouse cursor
function M.move(direction, speed)
  local step = (speed == "slow") and 10 or 40
  if direction == "left" then
    process.run(string.format("ydotool mousemove -- %d %d", -step, 0))
  elseif direction == "right" then
    process.run(string.format("ydotool mousemove -- %d %d", step, 0))
  elseif direction == "up" then
    process.run(string.format("ydotool mousemove -- %d %d", 0, -step))
  elseif direction == "down" then
    process.run(string.format("ydotool mousemove -- %d %d", 0, step))
  end
end

return M

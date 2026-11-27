local notify = require("util.notify")
local process = require("util.process")

local M = {}

local state = "released"

local YDOTOOL = {
  left_click = "ydotool click 0x40 0x80",
  right_click = "ydotool click 0x41 0x81",
  middle_click = "ydotool click 0x42 0x82",
  left_down = "ydotool click 0x40",
  left_up = "ydotool click 0x80",
  copy = "ydotool key 97:1 46:1 46:0 97:0", -- Ctrl+C (right ctrl, avoids the Control_L arrow bind)
}

--- Moves the pointer by dx/dy.
local function move_cursor(x, y)
  process.run(string.format("ydotool mousemove -- %d %d", x, y))
end

--- Mouse click
function M.click(button)
  if button == "left" then
    process.run(YDOTOOL.left_click)
    hl.dispatch(hl.dsp.submap("reset"))
  elseif button == "right" then
    process.run(YDOTOOL.right_click)
  elseif button == "middle" then
    process.run(YDOTOOL.middle_click)
  end
end

-- Toggle press/release + copy
function M.toggle()
  if state == "released" then
    state = "pressed"
    process.run(YDOTOOL.left_down)
  else
    state = "released"
    process.run(YDOTOOL.left_up)

    hl.timer(function()
      process.run(YDOTOOL.copy)
      process.run(YDOTOOL.left_click) -- clear selection

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
  process.run(YDOTOOL.left_up)
  hl.dispatch(hl.dsp.submap("reset"))
end

--- Moves the mouse cursor
function M.move(direction, speed)
  local step = (speed == "slow") and 10 or 40
  if direction == "left" or direction == "h" then
    move_cursor(-step, 0)
  elseif direction == "right" or direction == "l" then
    move_cursor(step, 0)
  elseif direction == "up" or direction == "k" then
    move_cursor(0, -step)
  elseif direction == "down" or direction == "j" then
    move_cursor(0, step)
  end
end

--- Move the pointer in the bottom-right outer gap and hides it.
function M.hide()
  hl.config({ ["cursor.invisible"] = true })
  local monitor = hl.get_active_monitor()
  if monitor then
    hl.dispatch(hl.dsp.cursor.move({
      x = monitor.x + monitor.width - 1,
      y = monitor.y + monitor.height - 1,
    }))
  end
end

--- Shows the pointer again, centered on the active monitor.
function M.center()
  hl.config({ ["cursor.invisible"] = false })
  local monitor = hl.get_active_monitor()
  if monitor then
    hl.dispatch(hl.dsp.cursor.move({
      x = math.floor(monitor.x + monitor.width / 2),
      y = math.floor(monitor.y + monitor.height / 2),
    }))
  end
end

return M

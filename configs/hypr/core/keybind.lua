local const = require("util.constant")
local zen = require("util.zen")
local zoom = require("util.zoom")
local layout = require("appearance.tiling")

-- Application launching
hl.bind(const.mod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(const.apps.browser))
hl.bind(const.mod .. " + RETURN", hl.dsp.exec_cmd(const.apps.terminal))
hl.bind(const.mod .. " + T", hl.dsp.exec_cmd(const.apps.terminal))
hl.bind(const.mod .. " + L", hl.dsp.exec_cmd(const.apps.lockscreen))
hl.bind(const.mod .. " + N", hl.dsp.exec_cmd(const.apps.notifpanel))
hl.bind(const.mod .. " + SLASH", hl.dsp.exec_cmd(const.scripts.websearch))
hl.bind(const.mod .. " + V", hl.dsp.exec_cmd(const.apps.ide))
hl.bind(const.mod .. " + E", hl.dsp.exec_cmd(const.apps.filemanager_gui))
hl.bind(const.mod .. " + P", hl.dsp.exec_cmd(const.apps.passmanager))

-- TUIs
hl.bind(
  const.mod .. " + SHIFT + B",
  hl.dsp.exec_cmd(const.apps.terminal .. " -e --class bluetooth " .. const.apps.bluetooth)
)
hl.bind(
  const.mod .. " + SHIFT + N",
  hl.dsp.exec_cmd(const.apps.terminal .. " -e --class network " .. const.apps.network)
)
hl.bind(
  const.mod .. " + SHIFT + E",
  hl.dsp.exec_cmd(const.apps.terminal .. " -e --class filemanager_tui " .. const.apps.filemanager_tui)
)
hl.bind(
  const.mod .. " + SHIFT + T",
  hl.dsp.exec_cmd(const.apps.terminal .. " -e --class taskmanager " .. const.apps.taskmanager)
)
hl.bind(
  const.mod .. " + SHIFT + M",
  hl.dsp.exec_cmd(
    const.apps.terminal .. " -d ~/Music/Better/OLD --class musicplayer " .. const.apps.musicplayer .. " ."
  )
)

hl.bind(
  const.mod .. " + B",
  hl.dsp.exec_cmd([[
  if systemctl --user is-active --quiet waybar.service; then
      systemctl --user disable --now waybar.service
  else
      systemctl --user enable --now waybar.service
  fi
]])
)

-- Window management
hl.bind(const.mod .. " + SHIFT + K", hl.dsp.window.kill())
hl.bind(const.mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(const.mod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))

hl.bind(const.mod .. " + SHIFT + P", function()
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
  hl.dispatch(hl.dsp.window.pin())
end)

-- Focus next window and bring active floating window to top
hl.bind("ALT + TAB", function()
  if layout.has_floating_windows() then
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
  end
end)

-- Focus previous window and bring to top
hl.bind("CTRL + SHIFT + TAB", function()
  if layout.has_floating_windows() then
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

-- Toggle zen mode
hl.bind(const.mod .. "+ SHIFT + Z", function()
  zen.toggle()
end)

-- Zoom in and out
hl.bind("SUPER + ALT + mouse_up", function()
  zoom.zoom_in()
end)
hl.bind("SUPER + ALT + mouse_down", function()
  zoom.zoom_out()
end)
hl.bind("SUPER + ALT + mouse:272", function()
  zoom.zoom_reset()
end)

-- Power menu
hl.bind("XF86PowerOff", hl.dsp.exec_cmd(const.scripts.powermenu))

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

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(const.scripts.mediactl .. " volume-up"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(const.scripts.mediactl .. " volume-down"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(const.scripts.mediactl .. " brightness-up"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(const.scripts.mediactl .. " brightness-down"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(const.scripts.mediactl .. " mute"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(const.scripts.mediactl .. " mic-mute"))

hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

hl.bind(const.mod .. "+ CTRL + 1", hl.dsp.exec_cmd(const.scripts.mediactl .. " mute"))
hl.bind(const.mod .. "+ CTRL + 2", hl.dsp.exec_cmd(const.scripts.mediactl .. " mic-mute"))
hl.bind(const.mod .. "+ CTRL + 3", hl.dsp.exec_cmd(const.scripts.mediactl .. " volume-down"), { repeating = true })
hl.bind(const.mod .. "+ CTRL + 4", hl.dsp.exec_cmd(const.scripts.mediactl .. " volume-up"), { repeating = true })
hl.bind(const.mod .. "+ CTRL + 5", hl.dsp.exec_cmd(const.scripts.mediactl .. " brightness-down"), { repeating = true })
hl.bind(const.mod .. "+ CTRL + 6", hl.dsp.exec_cmd(const.scripts.mediactl .. " brightness-up"), { repeating = true })
hl.bind(const.mod .. "+ CTRL + 7", hl.dsp.exec_cmd("playerctl previous"))
hl.bind(const.mod .. "+ CTRL + 8", hl.dsp.exec_cmd("playerctl next"))
hl.bind(const.mod .. "+ CTRL + 9", hl.dsp.exec_cmd("playerctl play-pause"))

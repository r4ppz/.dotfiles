local const = require("util.constant")
local zen = require("util.zen")
local zoom = require("util.zoom")

-- Power menu
hl.bind("XF86PowerOff", hl.dsp.exec_cmd(const.scripts.powermenu))

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

-- Toggle zen mode
hl.bind(const.mod .. "+ SHIFT + Z", function()
  zen.toggle()
end)

-- Zoom in and out
hl.bind(const.mod .. "+ ALT + mouse_up", function()
  zoom.zoom_in()
end)
hl.bind(const.mod .. "+ ALT + mouse_down", function()
  zoom.zoom_out()
end)
hl.bind(const.mod .. "+ ALT + mouse:272", function()
  zoom.zoom_reset()
end)

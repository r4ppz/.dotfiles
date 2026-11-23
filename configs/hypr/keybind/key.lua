local const = require("util.constant")
local zen = require("util.zen")
local zoom = require("util.zoom")
local bind = require("util.bind")

-- Power menu
bind("XF86PowerOff", hl.dsp.exec_cmd(const.scripts.powermenu))

-- Media keys
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(const.scripts.mediactl .. " volume-up"), { repeating = true })
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(const.scripts.mediactl .. " volume-down"), { repeating = true })
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(const.scripts.mediactl .. " brightness-up"), { repeating = true })
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(const.scripts.mediactl .. " brightness-down"), { repeating = true })
bind("XF86AudioMute", hl.dsp.exec_cmd(const.scripts.mediactl .. " mute"))
bind("XF86AudioMicMute", hl.dsp.exec_cmd(const.scripts.mediactl .. " mic-mute"))

bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"))
bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Toggle zen mode
bind(const.mod .. "+ SHIFT + Z", function()
  zen.toggle()
end)

-- Zoom in and out
bind({
  const.mod .. "+ SHIFT + mouse_up",
  const.mod .. "+ EQUAL",
}, function()
  zoom.up()
end)

bind({
  const.mod .. "+ SHIFT + mouse_down",
  const.mod .. "+ MINUS",
}, function()
  zoom.down()
end)

bind({
  const.mod .. "+ SHIFT + mouse:272",
  const.mod .. "+ BACKSPACE",
}, function()
  zoom.reset()
end)

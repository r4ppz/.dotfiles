local const = require("util.constant")
local bind = require("util.bind")

bind({
  const.mod .. " + RETURN",
  const.mod .. " + T",
}, hl.dsp.exec_cmd(const.apps.terminal))

bind(const.mod .. " + SLASH", hl.dsp.exec_cmd(const.scripts.websearch))
bind(const.mod .. " + E", hl.dsp.exec_cmd(const.apps.filemanager_gui))
bind(const.mod .. " + P", hl.dsp.exec_cmd(const.apps.passmanager))

bind(const.mod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(const.apps.terminal .. " -e zsh -lic 't'"), {
  tag = "+tmux",
})

bind(
  "ALT + SHIFT + E",
  hl.dsp.exec_cmd(
    const.apps.terminal
      .. " -e zsh -lic 'exec pi --no-tools --no-session \"explain this in simple words, do not use analogies:\n$(wl-paste -n)\"'",
    {
      tag = "+pi",
    }
  )
)

bind(
  const.mod .. " + C",
  hl.dsp.exec_cmd(const.apps.terminal .. " -e zsh -lic 'exec pi --no-session --no-tools'", {
    tag = "+pi",
  })
)

bind(
  const.mod .. " + SHIFT + B",
  hl.dsp.exec_cmd(const.apps.terminal .. " -e --class bluetooth " .. const.apps.bluetooth)
)

bind(const.mod .. " + SHIFT + N", hl.dsp.exec_cmd(const.apps.terminal .. " -e --class network " .. const.apps.network))

bind(
  const.mod .. " + SHIFT + E",
  hl.dsp.exec_cmd(const.apps.terminal .. " -e --class filemanager_tui " .. const.apps.filemanager_tui)
)

bind(
  const.mod .. " + SHIFT + T",
  hl.dsp.exec_cmd(const.apps.terminal .. " -e --class taskmanager " .. const.apps.taskmanager)
)

bind(
  const.mod .. " + SHIFT + M",
  hl.dsp.exec_cmd(
    const.apps.terminal .. " -d ~/Music/Better/OLD --class musicplayer " .. const.apps.musicplayer .. " ."
  )
)

bind(
  const.mod .. " + B",
  hl.dsp.exec_cmd([[
  if systemctl --user is-active --quiet waybar.service; then
      systemctl --user stop --now waybar.service
  else
      systemctl --user start --now waybar.service
  fi
]])
)

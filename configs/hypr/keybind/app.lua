local const = require("util.constant")

hl.bind(const.mod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(const.apps.browser))
hl.bind(const.mod .. " + RETURN", hl.dsp.exec_cmd(const.apps.terminal))
hl.bind(const.mod .. " + T", hl.dsp.exec_cmd(const.apps.terminal))
hl.bind(const.mod .. " + L", hl.dsp.exec_cmd(const.apps.lockscreen))
hl.bind(const.mod .. " + N", hl.dsp.exec_cmd(const.apps.notifpanel))
hl.bind(const.mod .. " + SLASH", hl.dsp.exec_cmd(const.scripts.websearch))
hl.bind(const.mod .. " + V", hl.dsp.exec_cmd(const.apps.ide))
hl.bind(const.mod .. " + E", hl.dsp.exec_cmd(const.apps.filemanager_gui))
hl.bind(const.mod .. " + P", hl.dsp.exec_cmd(const.apps.passmanager))

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

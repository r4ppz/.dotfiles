local process = require("util.process")
local notify = require("util.notify")

local M = {}

local OBS_WEBSOCKET_PORT = "1167"

function M.toggle()
  if process.is_port_listening(OBS_WEBSOCKET_PORT) then
    if process.run_ok("obs-cmd recording toggle") then
      notify.send("Recording", "Recording toggled", {
        timeout = 1500,
        app_name = "Recording",
        icon = "media-record",
        transient = true,
      })
    else
      notify.send("Recording", "Failed to toggle recording", {
        timeout = 1500,
        app_name = "Recording",
        icon = "dialog-error",
        urgency = "critical",
        transient = true,
      })
    end
    return
  end

  notify.send("Recording", "Starting OBS & recording...", {
    timeout = 1500,
    app_name = "Recording",
    icon = "com.obsproject.Studio",
    transient = true,
  })

  process.run("obs --startrecording --minimize-to-tray")
end

return M

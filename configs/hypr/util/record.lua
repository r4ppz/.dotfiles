local notify = require("util.notify")

local M = {}

local function is_obs_running()
  for _, file in ipairs({ "/proc/net/tcp", "/proc/net/tcp6" }) do
    local f = io.open(file, "r")
    if f then
      for line in f:lines() do
        if line:find(":1167") and line:find(" 0A ") then
          f:close()
          return true
        end
      end
      f:close()
    end
  end
  return false
end

local function succeeded(cmd)
  local f = io.popen("timeout 1 " .. cmd .. " >/dev/null 2>&1; echo $?")
  if not f then
    return false
  end
  local out = f:read("*a")
  f:close()
  local code = tonumber(out:match("(%d+)"))
  return code == 0
end

function M.toggle()
  if is_obs_running() then
    if succeeded("obs-cmd recording toggle") then
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

  hl.dispatch(hl.dsp.exec_cmd("obs --startrecording --minimize-to-tray"))
end

return M

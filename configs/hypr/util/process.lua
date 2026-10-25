local M = {}

function M.run(cmd)
  hl.dispatch(hl.dsp.exec_cmd(cmd))
end

function M.run_ok(cmd, timeout)
  timeout = timeout or 1
  local command = string.format("timeout %s %s >/dev/null 2>&1; echo $?", timeout, cmd)
  local handle = io.popen(command)
  if not handle then
    return false
  end
  local code = handle:read("*n")
  handle:close()
  return code == 0
end

function M.is_port_listening(port)
  local p = tostring(port)
  for _, file in ipairs({ "/proc/net/tcp", "/proc/net/tcp6" }) do
    local f = io.open(file, "r")
    if f then
      for line in f:lines() do
        if line:find(":" .. p) and line:find(" 0A ") then
          f:close()
          return true
        end
      end
      f:close()
    end
  end
  return false
end

function M.shell_quote(val)
  if type(val) ~= "string" then
    return tostring(val)
  end
  return "'" .. string.gsub(val, "'", "'\\''") .. "'"
end

return M

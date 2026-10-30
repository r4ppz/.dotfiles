local M = {}

M.internal = "eDP-1"
M.external = "HDMI-A-1"

local monitors = {
  {
    output = M.external,
    mode = "1920x1080@100",
    position = "0x0",
    scale = 1,
    -- mirror = M.internal,
  },
  {
    output = M.internal,
    mode = "1366x768@60",
    position = "1920x0",
    scale = 1,
    disabled = true,
    -- mirror = M.external,
  },
  {
    output = "", -- fallback
    mode = "preferred",
    position = "auto",
    scale = 1,
  },
}

local function apply()
  local internal_disabled = false

  for _, cfg in ipairs(monitors) do
    hl.monitor(cfg)
    if cfg.output == M.internal and cfg.disabled then
      internal_disabled = true
    end
  end

  hl.exec_scheduled_prop_refresh_immediately()

  local external_connected = hl.get_monitor(M.external) ~= nil
  local dual = external_connected and not internal_disabled
  local fallback = (external_connected and internal_disabled) and M.external or M.internal

  for id = 1, 10 do
    local workspace = tostring(id)
    local target = dual and (id == 10 and M.internal or M.external) or fallback

    hl.workspace_rule({
      workspace = workspace,
      monitor = target,
      default = (id == 1) or (dual and id == 10),
    })

    if hl.get_workspace(workspace) then
      hl.dispatch(hl.dsp.workspace.move({ workspace = workspace, monitor = target }))
    end
  end
end

apply()

local function on_monitor_change(m)
  if m.name == M.external then
    apply()
  end
end

hl.on("hyprland.start", apply)
hl.on("monitor.added", on_monitor_change)
hl.on("monitor.removed", on_monitor_change)

return M

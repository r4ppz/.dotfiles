local M = {}

M.internal = "eDP-1"
M.external = "HDMI-A-1"

local monitors = {
  {
    output = M.external,
    mode = "1920x1080@100",
    position = "auto-left",
    scale = 1,
    -- mirror = M.internal,
  },
  {
    output = M.internal,
    mode = "1366x768@60",
    position = "auto-right",
    scale = 1,
    disabled = false,
    -- mirror = M.external,
  },
  {
    output = "", -- fallback
    mode = "preferred",
    position = "auto",
    scale = 1,
  },
}

function M.apply_config()
  local external_connected = hl.get_monitor(M.external)

  for _, cfg in ipairs(monitors) do
    local final_cfg = {}

    for k, v in pairs(cfg) do
      final_cfg[k] = v
    end

    -- Prevent to fuck my shit
    if cfg.output == M.internal then
      final_cfg.disabled = external_connected and cfg.disabled or false
    end

    hl.monitor(final_cfg)
  end

  hl.exec_scheduled_prop_refresh_immediately()

  local fallback = external_connected and M.external or M.internal

  for id = 1, 10 do
    local workspace = tostring(id)
    -- 10 always belongs to the internal panel
    local target = (id == 10) and M.internal or fallback

    hl.workspace_rule({
      workspace = workspace,
      monitor = target,
      default = (id == 1) or (id == 10),
    })

    if hl.get_workspace(workspace) then
      hl.dispatch(hl.dsp.workspace.move({
        workspace = workspace,
        monitor = target,
      }))
    end
  end
end

M.apply_config()

return M

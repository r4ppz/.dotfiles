local M = {}

-- Port names as seen by `hyprctl monitors all`
M.internal = "eDP-1"
M.external = "HDMI-A-1"

-- Monitor specs (kept here for single source)
M.specs = {
  [M.external] = {
    mode = "1920x1080@100",
    scale = 1,
  },
  [M.internal] = {
    mode = "1366x768@60",
    scale = 1,
  },
}

return M

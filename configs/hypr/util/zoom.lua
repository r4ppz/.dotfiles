local M = {}

local MIN_ZOOM = 1.0
local MAX_ZOOM = 10.0
local STEP = 1.25

local function set_zoom(value)
  hl.config({
    cursor = {
      zoom_factor = math.max(MIN_ZOOM, math.min(MAX_ZOOM, value)),
    },
  })
end

function M.up()
  set_zoom(hl.get_config("cursor.zoom_factor") * STEP)
end

function M.down()
  set_zoom(hl.get_config("cursor.zoom_factor") / STEP)
end

function M.reset()
  set_zoom(MIN_ZOOM)
end

return M

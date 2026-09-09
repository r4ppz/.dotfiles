hl.config({
  general = {
    gaps_in = 10,
    gaps_out = 20,
    float_gaps = 5,

    border_size = 2,

    col = {
      active_border = "rgb(83A598)",
      inactive_border = "rgb(504945)",
    },

    resize_on_border = false,
    modal_parent_blocking = true,

    allow_tearing = true,
    no_focus_fallback = true,

    snap = {
      enabled = true,
      border_overlap = true,
      monitor_gap = 5,
      window_gap = 5,
    },
  },

  decoration = {
    rounding = 1,
    rounding_power = 5,

    active_opacity = 1,
    inactive_opacity = 1,
    fullscreen_opacity = 1.0,

    dim_inactive = true,
    dim_strength = 0.2,
    dim_special = 0.2,

    shadow = {
      enabled = false,
      range = 1,
      render_power = 1,
      sharp = false,
      color = "rgba(000000aa)",
    },

    blur = {
      enabled = false,
      special = true,
      size = 6,
      passes = 1,
      new_optimizations = true,
      ignore_opacity = true,
      xray = false,
      noise = 0.01,
    },

    glow = {
      enabled = false,
      range = 20,
      render_power = 3,
      color = "0xee1a1a1a",
      color_inactive = nil,
    },
  },

  render = {
    direct_scanout = 2,
    new_render_scheduling = true,
  },
})

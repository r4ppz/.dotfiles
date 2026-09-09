hl.config({
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    force_default_wallpaper = 0,
    disable_scale_notification = false,

    col = {
      splash = "rgb(FFFFFF)",
    },

    font_family = "JetBrainsMono Nerd Font",
    splash_font_family = "JetBrainsMono Nerd Font",

    on_focus_under_fullscreen = 2,
    exit_window_retains_fullscreen = false,
    focus_on_activate = true,
    always_follow_on_dnd = true,
    close_special_on_empty = true,
    middle_click_paste = true,

    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,

    enable_anr_dialog = true,

    enable_swallow = true,
    swallow_regex = "kitty",

    vrr = 1,
  },
})

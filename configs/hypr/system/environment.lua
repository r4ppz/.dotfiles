-- Force all apps to use Wayland.
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("GDK_BACKEND", "wayland,x11,*")

hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

hl.env("XCURSOR_THEME", "Hackneyed")
hl.env("XCURSOR_SIZE", "24")

hl.env("DOTFILES", os.getenv("DOTFILES") or os.getenv("HOME") .. "/.dotfiles")

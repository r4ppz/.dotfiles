-- Size of a float win as a % relative to monitor.
local function scaled_size(w, h)
  return { "monitor_w * " .. (w / 100), "monitor_h * " .. (h / 100) }
end

-- Pin window to a specific workspace

hl.window_rule({
  name = "bitwarden",
  match = { class = "bitwarden" },
  workspace = "special:window2",
})

hl.window_rule({
  name = "music",
  match = { class = "musicplayer|brave-music.youtube.com__-Default|chrome-music.youtube.com__-Default" },
  workspace = "special:window2",
})

hl.window_rule({
  name = "main browser in workspace 1",
  match = { class = "brave-origin" },
  workspace = 1,
})

hl.window_rule({
  name = "random bs in workspace 3",
  match = {
    initial_class = "com.obsproject.Studio|Visual Studio Code|ONLYOFFICE|md.obsidian.Obsidian|com.usebottles.bottles|com.belmoussaoui.Authenticator|org.kde.krita",
  },
  workspace = 3,
})

hl.window_rule({
  name = "school stuff in workspace 4",
  match = { class = "helium" },
  workspace = 4,
})

-- Floating win rules

hl.window_rule({
  name = "xdg-desktop-portal-gtk|ONLYOFFICE|etc popups",
  match = {
    initial_class = "^.*(xdg-desktop-portal-gtk|DesktopEditors).*$",
  },
  size = scaled_size(36.46, 46.30),
  pin = true,
  float = true,
  center = true,
})

hl.window_rule({
  name = "common-dialogs",
  match = {
    initial_title = "^.*(Open File|Open Files|Save File|Open Folder|Choose Files|Choose Folder|Create Folder|Select Folder|Open Document|Save As).*$",
  },
  size = scaled_size(36.46, 46.30),
  pin = true,
  float = true,
  center = true,
})

hl.window_rule({
  name = "file-ops",
  match = {
    initial_title = "^(Rename|Move|File Operation Progress).*$",
  },
  size = scaled_size(18.23, 12.04),
  float = true,
  center = true,
})

hl.window_rule({
  name = "other popups",
  match = {
    initial_title = "^.*(export-download|codeload|wants to).*$",
    modal = true,
  },
  float = true,
  center = true,
})

hl.window_rule({
  name = "smt managers",
  match = { initial_class = "taskmanager|network|bluetooth" },
  size = scaled_size(60, 70),
  pin = true,
  float = true,
  center = true,
})

hl.window_rule({
  name = "network dialog GUI",
  match = {
    initial_class = "^.*(nm-connection-editor|blueman-manager).*$",
  },
  size = scaled_size(41.67, 46.30),
  pin = true,
  float = true,
  center = true,
})

hl.window_rule({
  name = "tempai",
  match = {
    initial_class = "brave-duck.ai__chat-Default|chrome-duck.ai__chat-Default",
  },
  size = scaled_size(41.67, 55.56),
  pin = true,
  float = true,
  center = true,
})

hl.window_rule({
  name = "tempai using a tag",
  match = { tag = "pi" },
  size = scaled_size(41.67, 55.56),
  pin = true,
  float = true,
  center = true,
})

hl.window_rule({
  name = "just float dont pin",
  match = {
    title = "Select what to share|Cloudflare One Client",
  },
  float = true,
  center = true,
})

hl.window_rule({
  name = "just float but should stay focused",
  match = {
    class = "gsimplecal",
  },
  pin = true,
  float = true,
  center = true,
  stay_focused = true,
})

hl.window_rule({
  name = "just float",
  match = {
    class = "warp-taskbar|org.qbittorrent.qBittorrent",
  },
  pin = true,
  float = true,
  center = true,
})

-- Prevent screen idle/sleep
hl.window_rule({
  match = {
    initial_class = "brave-music.youtube.com__-Default",
  },
  idle_inhibit = "always",
})
hl.window_rule({
  match = {
    initial_class = "brave-www.youtube.com__-Default|musicplayer",
  },
  idle_inhibit = "focus",
})

-- Size of a float win as a % relative to monitor.
local function scaled_size(w, h)
  return { "monitor_w * " .. (w / 100), "monitor_h * " .. (h / 100) }
end

-- Pin window to a specific workspace

hl.window_rule({
  name = "Belongs to special:window2",
  match = {
    initial_class = "(?i).*(music|bitwarden).*",
  },
  workspace = "special:window2",
})

hl.window_rule({
  name = "main browser in workspace 1",
  match = { initial_class = "(?i)brave-origin" },
  workspace = 1,
})

hl.window_rule({
  name = "random bs in workspace 3",
  match = {
    initial_class = "(?i).*(obsproject|ONLYOFFICE|obsidian|bottles|authenticator|krita|tlauncher|code).*",
  },
  workspace = 3,
})

hl.window_rule({
  name = "school stuff in workspace 4",
  match = { class = "(?i)helium" },
  workspace = 4,
})

-- Floating win rules

hl.window_rule({
  name = "float-modals",
  match = {
    modal = true,
  },
  float = true,
  center = true,
})

hl.window_rule({
  name = "portal",
  match = {
    initial_class = "(?i).*xdg-desktop-portal-gtk.*",
  },
  size = scaled_size(35, 45),
  pin = true,
  float = true,
  center = true,
})

hl.window_rule({
  name = "other common-dialogs",
  match = {
    initial_title = "(?i).*(Open File|Open Files|Save File|Open Folder|Choose Files|Choose Folder|Create Folder|Select Folder|Open Document|Save As).*",
  },
  size = scaled_size(35, 45),
  pin = true,
  float = true,
})

hl.window_rule({
  name = "file-ops",
  match = {
    initial_title = "(?i).*(Rename|Move|File Operation Progress).*",
  },
  size = scaled_size(18, 12),
  float = true,
})

hl.window_rule({
  name = "other popups",
  match = {
    initial_title = "(?i).*(export-download|codeload|wants to).*$",
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
    initial_class = "(?i).*(nm-connection-editor|blueman-manager).*$",
  },
  size = scaled_size(40, 45),
  pin = true,
  float = true,
  center = true,
})

hl.window_rule({
  name = "tempai",
  match = {
    initial_class = "(?i).*ai__chat.*",
  },
  size = scaled_size(40, 55),
  pin = true,
  float = true,
  center = true,
})

hl.window_rule({
  name = "tempai using a tag",
  match = { tag = "pi" },
  size = scaled_size(40, 55),
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
    class = "(?i).*(warp-taskbar|qbittorrent).*",
  },
  pin = true,
  float = true,
  center = true,
})

-- Prevent screen idle/sleep
hl.window_rule({
  match = {
    initial_class = [[(?i).*(music\.youtube\.com|musicplayer).*]],
  },
  idle_inhibit = "always",
})

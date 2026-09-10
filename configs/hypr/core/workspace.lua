local const = require("util.constants")
local monitors = require("io.monitors")

-- Switch focus between monitors
hl.bind(const.mod .. " + COMMA", hl.dsp.focus({ monitor = monitors.external }))
hl.bind(const.mod .. " + PERIOD", hl.dsp.focus({ monitor = monitors.internal }))

-- Go to previous workspace
hl.bind(const.mod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Workspace navigation
hl.bind("Page_Up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("Page_Down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(const.mod .. "+ bracketleft", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(const.mod .. "+ bracketright", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(const.mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(const.mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

-- Switch workspaces with vars.mainMod + [0-9]
for i = 1, 10 do
  local key = i % 10
  hl.bind(const.mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(const.mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- -----------------------------------------------------------
-- Special workspace (scratchpad)
-- -----------------------------------------------------------

hl.workspace_rule({
  monitor = monitors.external,
  workspace = "special:window2",
  gaps_in = 3,
  gaps_out = {
    top = 180,
    right = 350,
    bottom = 180,
    left = 350,
  },
})

hl.bind(const.mod .. " + BACKSLASH", hl.dsp.workspace.toggle_special("window2"))
hl.bind(const.mod .. " + SHIFT + BACKSLASH", hl.dsp.window.move({ workspace = "special:window2" }))

hl.workspace_rule({
  monitor = monitors.external,
  workspace = "special:window1",
  gaps_in = 3,
  gaps_out = {
    top = 180,
    right = 350,
    bottom = 180,
    left = 350,
  },
})

hl.bind(const.mod .. " + W", hl.dsp.workspace.toggle_special("window1"))
hl.bind(const.mod .. " + SHIFT + W", hl.dsp.window.move({ workspace = "special:window1" }))

-- Minimize workspace
hl.workspace_rule({
  monitor = monitors.external,
  workspace = "special:minimize",
  gaps_in = 2,
  gaps_out = {
    top = 5,
    right = 5,
    bottom = 5,
    left = 5,
  },
  border_size = 0,
})

hl.bind(const.mod .. " + grave", hl.dsp.workspace.toggle_special("minimize"))
hl.bind(const.mod .. " + X", hl.dsp.window.move({ workspace = "special:minimize" }))

-- -----------------------------------------------------------
-- rules
-- -----------------------------------------------------------
hl.window_rule({
  name = "brave-browser",
  match = { class = "brave-browser" },
  workspace = 1,
})
hl.window_rule({
  name = "brave-browser",
  match = { class = "brave-origin-nightly|brave-origin" },
  workspace = 1,
})
hl.window_rule({
  name = "helium",
  match = { class = "helium" },
  workspace = 5,
})
hl.window_rule({
  name = "musicplayer",
  match = { class = "musicplayer" },
  workspace = "special:window2",
})
hl.window_rule({
  name = "google-classroom",
  match = {
    initial_class = "^chrome-classroom.google.com__-Default$",
  },
  workspace = 5,
})
hl.window_rule({
  name = "youtube-music",
  match = { initial_class = "^brave-music.youtube.com__-Default$" },
  workspace = 4,
})
hl.window_rule({
  name = "obs",
  match = { initial_class = "^com.obsproject.Studio$" },
  workspace = 3,
})
hl.window_rule({
  name = "vscode",
  match = { initial_title = "^(Visual Studio Code)$" },
  workspace = 3,
})
hl.window_rule({
  name = "onlyoffice",
  match = { class = "ONLYOFFICE" },
  workspace = 3,
})

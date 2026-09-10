local function floating_rule(opts)
  opts.pin = opts.pin ~= false and true or opts.pin
  opts.float = opts.float ~= false and true or opts.float
  opts.center = opts.center ~= false and true or opts.center

  hl.window_rule(opts)
end

-- Floating dialog windows
floating_rule({
  name = "xdg-desktop-portal-gtk",
  match = {
    initial_class = "^.*(xdg-desktop-portal-gtk).*$",
  },
  size = { "monitor_w * 0.3646", "monitor_h * 0.4630" },
})

floating_rule({
  name = "DesktopEditors",
  match = {
    initial_class = "^.*(DesktopEditors).*$",
  },
  size = { "monitor_w * 0.2969", "monitor_h * 0.1111" },
})

floating_rule({
  name = "common-dialogs",
  match = {
    initial_title = "^.*(Open File|Open Files|Save File|Open Folder|Choose Files|Choose Folder|Create Folder|Select Folder|Open Document|Save As).*$",
  },
  size = { "monitor_w * 0.3646", "monitor_h * 0.4630" },
})

floating_rule({
  name = "file-ops",
  match = {
    initial_title = "^(Rename|Move|File Operation Progress).*$",
  },
  size = { "monitor_w * 0.1823", "monitor_h * 0.1204" },
})

-- Web / specific popups
floating_rule({
  name = "export-download",
  match = {
    initial_title = "^.*(export-download|codeload|wants to).*$",
    modal = true,
  },
  size = { "monitor_w * 0.3646", "monitor_h * 0.4630" },
})

floating_rule({
  name = "task, network and bluetooth managers",
  match = { initial_class = "taskmanager|network|bluetooth" },
  size = { "monitor_w * 0.5208", "monitor_h * 0.6481" },
})

floating_rule({
  name = "bluetooth-dialogs-gui",
  match = {
    initial_class = "^.*(nm-connection-editor|blueman-manager).*$",
  },
  size = { "monitor_w * 0.4167", "monitor_h * 0.4630" },
})

floating_rule({
  name = "bitwarden",
  match = { initial_class = "Bitwarden" },
  size = { "monitor_w * 0.5208", "monitor_h * 0.6481" },
})

floating_rule({
  name = "tempai",
  match = {
    initial_class = "^brave-duck.ai__chat-Default|brave-chatgpt.com__-Default$",
  },
  size = { "monitor_w * 0.4167", "monitor_h * 0.5556" },
})

floating_rule({
  name = "gsimplecal",
  match = { class = "gsimplecal" },
})

-- Code fullscreen
hl.window_rule({
  name = "code-fullscreen",
  match = { class = "Code" },
  fullscreen_state = 2,
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

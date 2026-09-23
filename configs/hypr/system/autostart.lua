hl.on("hyprland.start", function()
  if os.getenv("UWSM_WAIT_VARNAMES") == nil then
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
  end
  hl.exec_cmd("systemctl --user start hyprland.target")
end)

hl.on("hyprland.shutdown", function()
  hl.exec_cmd("systemctl --user stop hyprland.target")
end)

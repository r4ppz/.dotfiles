hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user import-environment")
  hl.exec_cmd("dbus-update-activation-environment --systemd --all")
  hl.exec_cmd("systemctl --user start hyprland.target")
end)

hl.on("hyprland.shutdown", function()
  hl.exec_cmd("systemctl --user stop hyprland.target")
end)

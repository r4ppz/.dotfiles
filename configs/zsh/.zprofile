if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  if uwsm check may-start 2>/dev/null; then
    exec uwsm start hyprland-uwsm.desktop
  else
    exec start-hyprland
  fi
fi

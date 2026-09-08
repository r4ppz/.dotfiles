-- External Monitor (Left)
hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@100",
  position = "0x0",
  scale = 1,
  disabled = false,
})

-- Internal Laptop Screen (Right)
hl.monitor({
  output = "eDP-1",
  mode = "1366x768@60",
  position = "1920x0",
  scale = 1,
  disabled = false,
})

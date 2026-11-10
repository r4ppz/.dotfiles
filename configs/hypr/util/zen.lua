local notify = require("util.notify")
local process = require("util.process")
local monitor = require("system.monitor")

local M = {}

local dotfiles = os.getenv("DOTFILES") or os.getenv("HOME") .. "/.dotfiles"

local ZEN = {
  general = { gaps_in = 1, gaps_out = 0, border_size = 0 },
  decoration = { rounding = 0, rounding_power = 1 },
  wallpaper = dotfiles .. "/assets/plain-wallpaper.png",
  waybar = "stop",
  bezier = "easeOutQuint",
}

-- Souce: configs/hypr/appearance/animation.lua
local function normal_config()
  return {
    general = {
      gaps_in = hl.get_config("general.gaps_in"),
      gaps_out = hl.get_config("general.gaps_out"),
      border_size = hl.get_config("general.border_size"),
    },
    decoration = {
      rounding = hl.get_config("decoration.rounding"),
      rounding_power = hl.get_config("decoration.rounding_power"),
    },
    wallpaper = dotfiles .. "/assets/wallpaper2.png",
    waybar = "start",
    bezier = "bouncy",
  }
end

local zen = false
local baseline -- cached, captured on the first toggle

local function apply(conf)
  hl.config({
    general = conf.general,
    decoration = conf.decoration,
  })

  for _, mon in ipairs({ monitor.external, monitor.internal }) do
    process.run("hyprctl hyprpaper wallpaper " .. mon .. ", " .. conf.wallpaper .. ",cover")
  end

  process.run("systemctl --user " .. conf.waybar .. " waybar.service")

  hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 4,
    bezier = conf.bezier,
    style = "slide",
  })
end

function M.is_zen()
  return zen
end

function M.toggle()
  baseline = baseline or normal_config()
  zen = not zen

  apply(zen and ZEN or baseline)

  notify.send(zen and "Zen Mode" or "Normal Mode", nil, {
    timeout = 1000,
    app_name = "Zen Mode",
    icon = "dialog-information",
    transient = true,
  })
end

return M

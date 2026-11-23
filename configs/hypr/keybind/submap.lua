local const = require("util.constant")
local mouse = require("util.mouse")
local eyetemp = require("util.eyetemp")
local notify = require("util.notify")
local zen = require("util.zen")
local record = require("util.record")
local bind = require("util.bind")

--- Starts or restarts a 2-second inactivity timer.
local submap_timer = nil
local function start_submap_timer()
  if submap_timer then
    submap_timer:set_enabled(false)
  end
  submap_timer = hl.timer(function()
    hl.dispatch(hl.dsp.submap("reset"))
  end, { timeout = 2000, type = "oneshot" })
end

--- Enters a submap +  timer + notif
local function enter_submap(display_name, use_timer)
  hl.dispatch(hl.dsp.submap(display_name))
  if use_timer then
    start_submap_timer()
  end

  if zen.is_zen() then
    notify.send("Submap", display_name, {
      timeout = 1000,
      app_name = "Submap",
      icon = "dialog-information",
      transient = true,
    })
  end
end

--- Binds a key to open a URL in a browser
local function bind_site(browser, key, site_url)
  bind(key, hl.dsp.exec_cmd(browser .. " --new-tab " .. site_url))
  bind(const.mod .. " + " .. key, hl.dsp.exec_cmd(browser .. " --app=" .. site_url))
end

--- Runs an action, then leaves the current submap.
local function once(action)
  return function()
    if type(action) == "function" then
      action()
    else
      hl.dispatch(action)
    end
    hl.dispatch(hl.dsp.submap("reset"))
  end
end

-- ============================================================================
-- AI APPLICATIONS SUBMAP
-- ============================================================================
bind(const.mod .. " + A", function()
  enter_submap("AI Slop", true)
end)

hl.define_submap("AI Slop", "reset", function()
  bind_site(const.apps.browser, "V", const.websites.microsoft_copilot)
  bind_site(const.apps.browser, "K", const.websites.kimi)
  bind_site(const.apps.browser, "X", const.websites.github_copilot)
  bind_site(const.apps.browser, "C", const.websites.chatgpt)
  bind_site(const.apps.browser, "P", const.websites.perplexity)
  bind_site(const.apps.browser, "G", const.websites.gemini)
  bind_site(const.apps.browser, "D", const.websites.deepseek)
  bind_site(const.apps.browser, "N", const.websites.notebooklm)
  bind_site(const.apps.browser, "Q", const.websites.qwen)
  bind_site(const.apps.browser, "H", const.websites.huggingface)
  bind_site(const.apps.browser, "O", const.websites.duckduckgo)
  bind_site(const.apps.browser, "A", const.websites.claude)
  bind_site(const.apps.browser, "M", const.websites.meta)
  bind_site(const.apps.browser, "S", const.websites.googleaistudio)
  bind_site(const.apps.browser, "Z", const.websites.zai)
  bind_site(const.apps.browser, "L", const.websites.lumo)

  bind({ "catchall", "ESCAPE" }, hl.dsp.submap("reset"))
end)

-- ============================================================================
-- APPLICATIONS SUBMAP
-- ============================================================================
bind(const.mod .. " + SPACE", function()
  enter_submap("Applications", true)
end)

hl.define_submap("Applications", "reset", function()
  bind_site(const.apps.browser, "M", const.websites.mail)
  bind_site(const.apps.browser, "E", const.websites.getemoji)
  bind_site(const.apps.browser, "T", const.websites.monkeytype)
  bind_site(const.apps.browser, "W", const.websites.wifi)
  bind_site(const.apps.browser, "G", const.websites.gdocs)
  bind_site(const.apps.browser, "S", const.websites.speedtest)

  bind({ const.mod .. " + D", "D" }, hl.dsp.exec_cmd(const.apps.dictionary))
  bind({ const.mod .. " + B", "B" }, hl.dsp.exec_cmd(const.apps.browser))
  bind({ const.mod .. " + SPACE", "SPACE" }, hl.dsp.exec_cmd(const.scripts.launcher))
  bind({ const.mod .. " + P", "P" }, hl.dsp.exec_cmd(const.scripts.powermenu))
  bind({ const.mod .. " + L", "L" }, hl.dsp.exec_cmd(const.apps.lockscreen))
  bind({ const.mod .. " + N", "N" }, hl.dsp.exec_cmd(const.apps.notifpanel))

  bind({ "catchall", "ESCAPE" }, hl.dsp.submap("reset"))
end)

-- ============================================================================
-- DEVTOOLS SUBMAP
-- ============================================================================
bind(const.mod .. " + D", function()
  enter_submap("Dev Tools", true)
end)

hl.define_submap("Dev Tools", "reset", function()
  bind_site(const.apps.browser, "G", const.websites.github)
  bind_site(const.apps.browser, "A", const.websites.cloudflare)
  bind_site(const.apps.browser, "R", const.websites.coderabbit)
  bind_site(const.apps.browser, "F", const.websites.figma)
  bind_site(const.apps.browser, "D", const.websites.devdocs)
  bind_site(const.apps.browser, "W", const.websites.w3school)
  bind_site(const.apps.browser, "O", const.websites.google_cloud)
  bind_site(const.apps.browser, "E", const.websites.react_aria)
  bind_site(const.apps.browser, "H", const.websites.hl_wiki)
  bind_site(const.apps.browser, "S", const.websites.qs_wiki)
  bind_site(const.apps.browser, "Q", const.websites.qml_wiki)
  bind_site(const.apps.browser, "V", const.websites.nvim_docs)
  bind_site(const.apps.browser, "B", const.websites.codeberg)
  bind_site(const.apps.browser, "Z", const.websites.zig)
  bind_site(const.apps.browser, "L", const.websites.leetcode)
  bind_site(const.apps.browser, "X", const.websites.learnxinyminutes)
  bind_site(const.apps.browser, "T", const.websites.picoctf)
  bind_site(const.apps.browser, "C", const.websites.oklch)

  bind({ "catchall", "ESCAPE" }, hl.dsp.submap("reset"))
end)

-- ============================================================================
-- NIX SUBMAP
-- ============================================================================
bind(const.mod .. " + N", function()
  enter_submap("Nix", true)
end)

hl.define_submap("Nix", "reset", function()
  bind_site(const.apps.browser, "P", const.websites.nixos_pkg)
  bind_site(const.apps.browser, "O", const.websites.nixos_opt)
  bind_site(const.apps.browser, "N", const.websites.noggle)
  bind_site(const.apps.browser, "W", const.websites.nixos_wiki)
  bind_site(const.apps.browser, "S", const.websites.channel_status)
  bind_site(const.apps.browser, "T", const.websites.nixpkg_traker)

  bind({ "catchall", "ESCAPE" }, hl.dsp.submap("reset"))
end)

-- ============================================================================
-- MEDIA SUBMAP
-- ============================================================================
bind(const.mod .. " + M", function()
  enter_submap("Media", true)
end)

hl.define_submap("Media", "reset", function()
  bind_site(const.apps.browser, "A", const.websites.annas_archive)
  bind_site(const.apps.browser, "Y", const.websites.youtube)
  bind_site(const.apps.browser, "F", const.websites.facebook)
  bind_site(const.apps.browser, "N", const.websites.news)
  bind_site(const.apps.browser, "S", const.websites.spotify)
  bind_site(const.apps.browser, "M", const.websites.ytmusic)
  bind_site(const.apps.browser, "V", const.websites.movie)
  bind_site(const.apps.browser, "G", const.websites.manga)
  bind_site(const.apps.browser, "I", const.websites.medium)
  bind_site(const.apps.browser, "P", const.websites.psypost)

  bind({ "catchall", "ESCAPE" }, hl.dsp.submap("reset"))
end)

-- ============================================================================
-- SCHOOL WORKS SUBMAP
-- ============================================================================
bind(const.mod .. " + S", function()
  enter_submap("School", true)
end)

hl.define_submap("School", "reset", function()
  bind_site(const.apps.browser_school, "C", const.websites.classroom)
  bind_site(const.apps.browser_school, "M", const.websites.mail)
  bind_site(const.apps.browser_school, "O", const.websites.olsis)
  bind_site(const.apps.browser_school, "D", const.websites.drive)
  bind_site(const.apps.browser_school, "G", const.websites.gdocs)
  bind_site(const.apps.browser_school, "A", const.websites.claude)

  bind(const.mod .. " + S", hl.dsp.exec_cmd(const.apps.browser_school))

  bind({ "catchall", "ESCAPE" }, hl.dsp.submap("reset"))
end)

-- ============================================================================
-- UTILITIES SUBMAP
-- ============================================================================
bind(const.mod .. " + U", function()
  enter_submap("Util", false)
end)

hl.define_submap("Util", function()
  bind("SHIFT + S", once(hl.dsp.exec_cmd(const.scripts.screenshot .. " --full")))
  bind("S", once(hl.dsp.exec_cmd(const.scripts.screenshot .. " --region --copy")))
  bind("T", once(hl.dsp.exec_cmd(const.scripts.screenshot .. " --region --tmp --copy")))
  bind("O", once(hl.dsp.exec_cmd(const.scripts.ocr)))
  bind("P", once(hl.dsp.exec_cmd(const.apps.colorpicker)))
  bind("C", once(hl.dsp.exec_cmd(const.apps.calendar)))
  bind("R", once(record.toggle))

  bind("E", eyetemp.toggle)
  bind("1", hl.dsp.exec_cmd(const.scripts.mediactl .. " mute"))
  bind("2", hl.dsp.exec_cmd(const.scripts.mediactl .. " mic-mute"))
  bind("3", hl.dsp.exec_cmd(const.scripts.mediactl .. " volume-down"), { repeating = true })
  bind("4", hl.dsp.exec_cmd(const.scripts.mediactl .. " volume-up"), { repeating = true })
  bind("5", hl.dsp.exec_cmd(const.scripts.mediactl .. " brightness-down"), { repeating = true })
  bind("6", hl.dsp.exec_cmd(const.scripts.mediactl .. " brightness-up"), { repeating = true })
  bind("7", hl.dsp.exec_cmd("playerctl previous"))
  bind("8", hl.dsp.exec_cmd("playerctl next"))
  bind("9", hl.dsp.exec_cmd("playerctl play-pause"))

  bind({ "catchall", "ESCAPE" }, hl.dsp.submap("reset"))
end)

-- ============================================================================
-- RESIZE WINDOWS SUBMAP
-- ============================================================================
bind(const.mod .. " + R", function()
  enter_submap("resize", false)
end)

hl.define_submap("resize", function()
  local step = 20

  bind({ "right", "l" }, hl.dsp.window.resize({ x = step, y = 0, relative = true }), { repeating = true })
  bind({ "left", "h" }, hl.dsp.window.resize({ x = -step, y = 0, relative = true }), { repeating = true })
  bind({ "up", "k" }, hl.dsp.window.resize({ x = 0, y = -step, relative = true }), { repeating = true })
  bind({ "down", "j" }, hl.dsp.window.resize({ x = 0, y = step, relative = true }), { repeating = true })

  bind("escape", hl.dsp.submap("reset"))
end)

-- ============================================================================
-- MOUSE MODE SUBMAP
-- ============================================================================
bind(const.mod .. " + Q", function()
  enter_submap("Mouse Mode", false)
end)

hl.define_submap("Mouse Mode", function()
  -- Normal speed
  bind({ "left", "h" }, function()
    mouse.move("left")
  end, { repeating = true })

  bind({ "down", "j" }, function()
    mouse.move("down")
  end, { repeating = true })

  bind({ "right", "l" }, function()
    mouse.move("right")
  end, { repeating = true })

  bind({ "up", "k" }, function()
    mouse.move("up")
  end, { repeating = true })

  -- Slow speed
  bind({ "SHIFT + left", "SHIFT + h" }, function()
    mouse.move("left", "slow")
  end, { repeating = true })

  bind({ "SHIFT + down", "SHIFT + j" }, function()
    mouse.move("down", "slow")
  end, { repeating = true })

  bind({ "SHIFT + right", "SHIFT + l" }, function()
    mouse.move("right", "slow")
  end, { repeating = true })

  bind({ "SHIFT + up", "SHIFT + k" }, function()
    mouse.move("up", "slow")
  end, { repeating = true })

  bind("KP_Insert", function()
    mouse.click("left")
  end)
  bind("KP_Enter", function()
    mouse.click("right")
  end)
  bind("KP_Delete", function()
    mouse.click("middle")
  end)
  bind("KP_End", mouse.toggle)

  bind("Q", function()
    mouse.click("left")
  end)
  bind("W", function()
    mouse.click("right")
  end)
  bind("E", function()
    mouse.click("middle")
  end)
  bind("R", mouse.toggle)

  -- I dont have an arrowkeys :(
  bind("Alt_R", hl.dsp.send_shortcut({ mods = "", key = "Left" }))
  bind("slash", hl.dsp.send_shortcut({ mods = "", key = "Up" }))
  bind("Menu", hl.dsp.send_shortcut({ mods = "", key = "Down" }))
  bind("Control_L", hl.dsp.send_shortcut({ mods = "", key = "Right" }))

  bind("escape", mouse.reset)
end)

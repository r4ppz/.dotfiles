local const = require("util.constants")
local mouse = require("util.mouse")
local eyetemp = require("util.eyetemp")
local notify = require("util.notify")
local zen = require("util.zen")
local record = require("util.record")

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
  hl.bind(key, hl.dsp.exec_cmd(browser .. " --new-tab " .. site_url))
  hl.bind(const.mod .. " + " .. key, hl.dsp.exec_cmd(browser .. " --app=" .. site_url))
end

local function bind_exits()
  hl.bind("catchall", hl.dsp.submap("reset"))
  hl.bind("escape", hl.dsp.submap("reset"))
end

-- ============================================================================
-- AI APPLICATIONS SUBMAP
-- ============================================================================
hl.bind(const.mod .. " + A", function()
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
  bind_site(const.apps.browser, "M", const.websites.mistral)
  bind_site(const.apps.browser, "A", const.websites.claude)
  bind_site(const.apps.browser, "T", const.websites.meta)
  bind_site(const.apps.browser, "S", const.websites.googleaistudio)

  bind_exits()
end)

-- ============================================================================
-- APPLICATIONS SUBMAP
-- ============================================================================
hl.bind(const.mod .. " + SPACE", function()
  enter_submap("Applications", true)
end)

hl.define_submap("Applications", "reset", function()
  bind_site(const.apps.browser, "D", const.websites.drive)
  bind_site(const.apps.browser, "M", const.websites.mail)
  bind_site(const.apps.browser, "E", const.websites.getemoji)
  bind_site(const.apps.browser, "T", const.websites.monkeytype)
  bind_site(const.apps.browser, "W", const.websites.wifi)
  bind_site(const.apps.browser, "G", const.websites.gdocs)

  hl.bind(const.mod .. " + B", hl.dsp.exec_cmd(const.apps.browser))
  hl.bind(const.mod .. " + SPACE", hl.dsp.exec_cmd(const.scripts.launcher))

  bind_exits()
end)

-- ============================================================================
-- DEVTOOLS SUBMAP
-- ============================================================================
hl.bind(const.mod .. " + D", function()
  enter_submap("Dev Tools", true)
end)

hl.define_submap("Dev Tools", "reset", function()
  bind_site(const.apps.browser, "G", const.websites.github)
  bind_site(const.apps.browser, "C", const.websites.cloudflare)
  bind_site(const.apps.browser, "R", const.websites.coderabbit)
  bind_site(const.apps.browser, "F", const.websites.figma)
  bind_site(const.apps.browser, "A", const.websites.arch)
  bind_site(const.apps.browser, "V", const.websites.vercel)
  bind_site(const.apps.browser, "D", const.websites.devdocs)
  bind_site(const.apps.browser, "W", const.websites.w3school)
  bind_site(const.apps.browser, "O", const.websites.google_cloud)
  bind_site(const.apps.browser, "E", const.websites.react_aria)
  bind_site(const.apps.browser, "H", const.websites.hl_wiki)
  bind_site(const.apps.browser, "Q", const.websites.qs_wiki)
  bind_site(const.apps.browser, "B", const.websites.codeberg)
  bind_site(const.apps.browser, "Z", const.websites.zig)
  bind_site(const.apps.browser, "L", const.websites.leetcode)
  bind_site(const.apps.browser, "X", const.websites.learnxinyminutes)
  bind_site(const.apps.browser, "N", const.websites.nixossearch)
  bind_site(const.apps.browser, "M", const.websites.hmoptsearch)
  bind_site(const.apps.browser, "T", const.websites.picoctf)

  bind_exits()
end)

-- ============================================================================
-- MEDIA SUBMAP
-- ============================================================================
hl.bind(const.mod .. " + M", function()
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
  bind_site(const.apps.browser, "D", const.websites.discord)
  bind_site(const.apps.browser, "R", const.websites.reddit)

  bind_exits()
end)

-- ============================================================================
-- SCHOOL WORKS SUBMAP
-- ============================================================================
hl.bind(const.mod .. " + S", function()
  enter_submap("School", true)
end)

hl.define_submap("School", "reset", function()
  bind_site(const.apps.browser_school, "C", const.websites.classroom)
  bind_site(const.apps.browser_school, "M", const.websites.mail)
  bind_site(const.apps.browser_school, "O", const.websites.olsis)
  bind_site(const.apps.browser_school, "D", const.websites.drive)
  bind_site(const.apps.browser_school, "G", const.websites.gdocs)

  hl.bind(const.mod .. " + S", hl.dsp.exec_cmd(const.apps.browser_school))

  bind_exits()
end)

-- ============================================================================
-- UTILITIES SUBMAP
-- ============================================================================
hl.bind(const.mod .. " + U", function()
  enter_submap("Util", false)
end)

hl.define_submap("Util", "reset", function()
  hl.bind("SHIFT + S", hl.dsp.exec_cmd(const.scripts.screenshot .. " --full"))
  hl.bind("S", hl.dsp.exec_cmd(const.scripts.screenshot .. " --region --copy"))
  hl.bind("T", hl.dsp.exec_cmd(const.scripts.screenshot .. " --region --tmp --copy"))
  hl.bind("O", hl.dsp.exec_cmd(const.scripts.ocr))
  hl.bind("R", record.toggle)
  hl.bind("C", hl.dsp.exec_cmd(const.apps.colorpicker))
  hl.bind("E", eyetemp.toggle)
  bind_exits()
end)

-- ============================================================================
-- RESIZE WINDOWS SUBMAP
-- ============================================================================
hl.bind(const.mod .. " + R", function()
  enter_submap("resize", false)
end)

hl.define_submap("resize", function()
  hl.bind("right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
  hl.bind("left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
  hl.bind("up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
  hl.bind("down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

  hl.bind("escape", hl.dsp.submap("reset"))
end)

-- ============================================================================
-- MOUSE MODE SUBMAP
-- ============================================================================
hl.bind(const.mod .. " + Q", function()
  enter_submap("Mouse Mode", false)
end)

hl.define_submap("Mouse Mode", function()
  -- Normal speed
  hl.bind("left", function()
    mouse.move("left")
  end, { repeating = true })
  hl.bind("down", function()
    mouse.move("down")
  end, { repeating = true })
  hl.bind("right", function()
    mouse.move("right")
  end, { repeating = true })
  hl.bind("up", function()
    mouse.move("up")
  end, { repeating = true })

  -- Slow speed
  hl.bind("SHIFT + left", function()
    mouse.move("left", "slow")
  end, { repeating = true })
  hl.bind("SHIFT + down", function()
    mouse.move("down", "slow")
  end, { repeating = true })
  hl.bind("SHIFT + right", function()
    mouse.move("right", "slow")
  end, { repeating = true })
  hl.bind("SHIFT + up", function()
    mouse.move("up", "slow")
  end, { repeating = true })

  hl.bind("KP_Insert", function()
    mouse.click("left")
  end)
  hl.bind("KP_Enter", function()
    mouse.click("right")
  end)
  hl.bind("KP_Delete", function()
    mouse.click("middle")
  end)
  hl.bind("KP_End", mouse.toggle)

  hl.bind("Q", function()
    mouse.click("left")
  end)
  hl.bind("W", function()
    mouse.click("right")
  end)
  hl.bind("E", function()
    mouse.click("middle")
  end)
  hl.bind("R", mouse.toggle)

  hl.bind("escape", mouse.reset)
end)

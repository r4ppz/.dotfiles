local M = {}

M.mod = "SUPER"

M.apps = {
  terminal = "kitty",
  browser = "brave-origin",
  browser_school = "helium-browser",
  filemanager_gui = "thunar",
  filemanager_tui = "yazi",
  lockscreen = "hyprlock",
  notifpanel = "swaync-client -t",
  colorpicker = "hyprpicker -a",
  ide = "code",
  passmanager = "bitwarden",
  taskmanager = "btop",
  musicplayer = "cliamp",
  bluetooth = "bluetui",
  network = "impala",
}

M.scripts = {
  launcher = "$DOTFILES/configs/rofi/launcher/launcher.sh",
  powermenu = "$DOTFILES/configs/rofi/powermenu/powermenu.sh",
  websearch = "$DOTFILES/configs/rofi/websearch/websearch.sh",
  screenshot = "$DOTFILES/scripts/bin/screenshot.sh",
  screenshotfull = "$DOTFILES/scripts/bin/screenshot-full.sh",
  ocr = "$DOTFILES/scripts/bin/ocr.sh",
  mediactl = "$DOTFILES/scripts/bin/mediactl.sh",
  record = "$DOTFILES/scripts/bin/toggle-obs.sh",
}

M.websites = {
  -- ai shit
  microsoft_copilot = "https://copilot.microsoft.com/chats/temporary",
  github_copilot = "https://github.com/copilot",
  kimi = "https://www.kimi.com",
  chatgpt = "https://chatgpt.com/?temporary-chat=true",
  perplexity = "https://www.perplexity.ai",
  gemini = "https://gemini.google.com/app",
  deepseek = "https://chat.deepseek.com",
  notebooklm = "https://notebooklm.google.com",
  qwen = "https://chat.qwen.ai/?temporary-chat=true",
  claude = "https://claude.ai",
  huggingface = "https://huggingface.co/chat",
  duckduckgo = "https://duck.ai/chat",
  mistral = "https://chat.mistral.ai/incognito",
  meta = "https://www.meta.ai",
  googleaistudio = "https://aistudio.google.com",

  drive = "https://drive.google.com/drive/my-drive",
  mail = "https://mail.google.com",
  getemoji = "https://getemoji.com",
  monkeytype = "https://monkeytype.com",
  wifi = "http://192.168.1.254",

  -- school
  classroom = "https://classroom.google.com",
  olsis = "https://tsis.assumptiondavao.edu.ph",
  gdocs = "https://docs.google.com/document/u/0/",

  -- media stuff
  annas_archive = "https://annas-archive.pk",
  youtube = "https://www.youtube.com",
  facebook = "https://www.facebook.com/messages",
  news = "https://news.ycombinator.com",
  spotify = "https://open.spotify.com",
  ytmusic = "https://music.youtube.com",
  movie = "https://www.fmovies.gd",
  manga = "https://mangakatana.com",
  medium = "https://medium.com",
  discord = "https://discord.com/channels/@me",
  reddit = "https://reddit.com",

  -- dev stuff
  codeberg = "https://codeberg.org",
  github = "https://github.com/r4ppz",
  devdocs = "https://devdocs.io",
  arch = "https://archlinux.org",
  coderabbit = "https://app.coderabbit.ai/wizard",
  figma = "https://www.figma.com",
  vercel = "https://vercel.com/r4ppz",
  cloudflare = "https://dash.cloudflare.com",
  w3school = "https://www.w3schools.com",
  google_cloud = "https://console.cloud.google.com/apis",
  react_aria = "https://react-aria.adobe.com/getting-started",
  hl_wiki = "https://wiki.hypr.land",
  qs_wiki = "https://quickshell.org/docs/v0.3.0/guide/introduction/",
  zig = "https://ziglang.org/documentation/0.16.0/",
  leetcode = "https://leetcode.com",
  learnxinyminutes = "https://learnxinyminutes.com",
}

return M

local M = {}

local function find_lombok_jar()
  local candidates = {
    vim.fn.expand("~/.nix-profile/share/java/lombok.jar"),
    "/etc/profiles/per-user/" .. (os.getenv("USER") or "") .. "/share/java/lombok.jar",
    "/run/current-system/sw/share/java/lombok.jar",
  }

  -- Check direct profile symlinks first
  for _, path in ipairs(candidates) do
    if vim.fn.filereadable(path) == 1 then
      return path
    end
  end

  -- Fallback: search nix store safely (returns a table)
  local nix_store_jars = vim.fn.glob("/nix/store/*-lombok-*/share/java/lombok.jar", false, true)
  if #nix_store_jars > 0 and vim.fn.filereadable(nix_store_jars[1]) == 1 then
    return nix_store_jars[1]
  end

  return nil
end

function M.setup(capabilities)
  if vim.fn.exepath("jdtls") == "" then
    vim.notify("jdtls not found in PATH. Is jdt-language-server installed?", vim.log.levels.ERROR)
    return
  end

  local java_home = os.getenv("JAVA_HOME")
  local lombok_jar = find_lombok_jar()

  if not lombok_jar then
    vim.notify("Lombok jar not found! JDTLS will start without Lombok agent.", vim.log.levels.WARN)
  end

  -- Workspace directory based on current working directory hash to avoid name collisions
  local cwd = vim.fn.getcwd()
  local project_name = vim.fn.fnamemodify(cwd, ":p:h:t")
  local hash = vim.fn.sha256(cwd):sub(1, 8)
  local workspace_dir =
    vim.fn.expand("~/.local/share/jdtls-workspace/" .. project_name .. "-" .. hash)

  local cmd = { "jdtls", "-data", workspace_dir }
  if lombok_jar then
    table.insert(cmd, 2, "--jvm-arg=-javaagent:" .. lombok_jar)
  end

  vim.lsp.config("jdtls", {
    filetypes = { "java" },
    capabilities = capabilities,
    root_markers = {
      "pom.xml",
      "build.gradle",
      "build.gradle.kts",
      "settings.gradle",
      "gradlew",
      "mvnw",
      ".git",
    },

    cmd = cmd,

    settings = {
      java = {
        home = java_home,
        autobuild = { enabled = true },
        contentProvider = { preferred = "fernflower" },
        completion = {
          favoriteStaticMembers = {
            "org.junit.jupiter.api.Assertions.*",
            "org.mockito.Mockito.*",
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.springframework.boot.SpringApplication.*",
            "org.springframework.boot.autoconfigure.SpringBootApplication.*",
            "org.springframework.web.bind.annotation.*",
            "org.springframework.http.ResponseEntity.*",
          },
          filteredTypes = {
            "com.sun.*",
            "java.awt.*",
            "jdk.*",
            "sun.*",
            "org.springframework.cglib.*",
            "org.springframework.boot.loader.*",
          },
          importOrder = { "java", "javax", "com", "org", "lombok" },
        },
        referencesCodeLens = { enabled = true },
        configuration = {
          updateBuildConfiguration = "automatic",
          maven = {
            userSettings = vim.fn.expand("~/.m2/settings.xml"),
            globalSettings = "/etc/maven/settings.xml",
          },
          runtimes = java_home and {
            {
              name = "JavaSE-21",
              path = java_home,
              default = true,
            },
          } or nil,
        },

        format = {
          enabled = false,
        },
        saveActions = {
          organizeImports = false,
        },

        import = {
          gradle = {
            enabled = true,
            offline = { enabled = false },
            wrapper = { enabled = true },
          },
          maven = { enabled = true },
        },

        maven = {
          downloadSources = true,
          updateSnapshots = true,
        },

        project = {
          referencedLibraries = { "lib/**/*.jar", "./out/**/*.jar" },
        },

        sources = {
          organizeImports = {
            starThreshold = 999,
            staticStarThreshold = 999,
          },
        },
      },
    },

    on_attach = function(client, _)
      client.server_capabilities.semanticTokensProvider = nil
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  })
end

return M

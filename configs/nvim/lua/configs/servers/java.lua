local M = {}

function M.setup(capabilities)
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = vim.fn.expand("~/.local/share/jdtls-workspace/" .. project_name)

  local java_home = os.getenv("JAVA_HOME")

  if vim.fn.exepath("jdtls") == "" then
    vim.notify("jdtls not found in PATH. Is jdt-language-server installed?", vim.log.levels.ERROR)
    return
  end

  -- Use nix-provided jdtls wrapper (handles -Dosgi.sharedConfiguration.area.readOnly=true etc.)
  local lombok_jar = nil
  local nix_paths = {
    vim.fn.expand("~/.nix-profile/share/java/lombok.jar"),
    vim.fn.glob("/nix/store/*/lombok-*/lombok.jar"),
  }
  for _, p in ipairs(nix_paths) do
    if p ~= "" and vim.fn.filereadable(p) == 1 then
      lombok_jar = p
      break
    end
  end

  local cmd = { "jdtls", "-data", workspace_dir }
  if lombok_jar then
    table.insert(cmd, 2, "--jvm-arg=-javaagent:" .. lombok_jar)
  end

  vim.lsp.config("jdtls", {
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
        contentProvider = { preferred = { "fernflower" } },
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
          runtimes = {
            { name = "JavaSE-21", path = java_home, default = true },
          },
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
            offline = { enabled = true },
            version = "8.5",
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

    on_attach = function(client)
      client.server_capabilities.semanticTokensProvider = nil
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  })
end

return M

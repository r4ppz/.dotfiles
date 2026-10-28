local map = require("utils.map")
local system = require("utils.system")

-- LazyGit floating terminal
map("n", { "<M-g>", "<leader>gg" }, function()
  if not system.is_git_repo(vim.fn.getcwd()) then
    return vim.notify("Current dir is not a git repo", vim.log.levels.INFO)
  end

  Snacks.lazygit.open()
end, { desc = "Lazygit (Snacks)" })

-- gitsign navigation
map("n", "]c", function()
  require("gitsigns").nav_hunk("next")
end, { desc = "Next Git Hunk (GitSign)" })
map("n", "[c", function()
  require("gitsigns").nav_hunk("prev")
end, { desc = "Previous Git Hunk (GitSign)" })

-- stage hunk/buffer
map("n", "<leader>gs", function()
  require("gitsigns").stage_hunk()
end, { desc = "Stage Hunk (GitSign)" })
map("n", "<leader>gS", function()
  require("gitsigns").stage_buffer()
end, { desc = "Stage Buffer (GitSign)" })

-- reset hunk/buffer
map("n", "<leader>gr", function()
  require("gitsigns").reset_hunk()
end, { desc = "Reset Hunk (GitSign)" })
map("n", "<leader>gR", function()
  require("gitsigns").reset_buffer()
end, { desc = "Reset Buffer (GitSign)" })

-- preview changes/blame
map("n", "<leader>gP", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview Hunk (GitSign)" })
map("n", "<leader>gp", function()
  require("gitsigns").preview_hunk_inline()
end, { desc = "Preview Hunk Inline (GitSign)" })
map("n", "<leader>gb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Blame Line (GitSign)" })
map("n", "<leader>gB", function()
  require("gitsigns").blame()
end, { desc = "Blame (GitSign)" })

-- DiffView
map("n", "<leader>gd", function()
  if not system.is_git_repo(vim.fn.getcwd()) then
    return vim.notify("Current dir is not a git repo", vim.log.levels.INFO)
  end
  vim.cmd("DiffviewOpen")
end, {
  desc = "Open Diffview",
})

map("n", "<leader>gh", function()
  if not system.is_git_repo(vim.fn.getcwd()) then
    return vim.notify("Current dir is not a git repo", vim.log.levels.INFO)
  end
  vim.cmd("DiffviewFileHistory")
end, {
  desc = "Open Diffview History (Diffview)",
})

map("n", "<leader>gf", function()
  if not system.is_git_repo(vim.fn.getcwd()) then
    return vim.notify("Current dir is not a git repo", vim.log.levels.INFO)
  end
  vim.cmd("DiffviewFileHistory %")
end, {
  desc = "Open Diffview Current File History (Diffview)",
})

-- Interactive Branch Comparison using vim.ui.select
map("n", "<leader>gD", function()
  if not system.is_git_repo(vim.fn.getcwd()) then
    return vim.notify("Current dir is not a git repo", vim.log.levels.INFO)
  end

  -- Fetch all branches (local and remote)
  local raw_branches = vim.fn.systemlist("git branch -a --format='%(refname:short)'")
  if vim.v.shell_error ~= 0 or #raw_branches == 0 then
    vim.notify("Not a git repository or no branches found", vim.log.levels.ERROR)
    return
  end

  -- Clean up names: remove 'remotes/' prefix and filter out HEAD artifacts
  local branches = {}
  for _, branch in ipairs(raw_branches) do
    if not string.find(branch, "HEAD") and branch ~= "" and branch ~= "origin" then
      -- Strips 'remotes/origin/main' down to 'origin/main' for cleaner UI and commands
      local clean_name = string.gsub(branch, "^remotes/", "")
      table.insert(branches, clean_name)
    end
  end

  -- Select baseline revision (Left Side)
  vim.ui.select(branches, {
    prompt = "Diffview: Select Baseline (Left Side) > ",
  }, function(left_rev)
    if not left_rev then
      return
    end -- User aborted

    -- Select target revision (Right Side)
    vim.schedule(function()
      vim.ui.select(branches, {
        prompt = string.format(
          "Diffview: Select Target (Right Side, comparing vs %s) > ",
          left_rev
        ),
      }, function(right_rev)
        if not right_rev then
          return
        end -- User aborted

        -- Execute the range comparison
        local cmd = string.format("DiffviewOpen %s..%s", left_rev, right_rev)
        vim.cmd(cmd)
      end)
    end)
  end)
end, {
  desc = "Open Diffview branch comparison (inc. remotes)",
})

-- Direct Hash/Revision Comparison via vim.ui.input
map("n", "<leader>gc", function()
  if not system.is_git_repo(vim.fn.getcwd()) then
    return vim.notify("Current dir is not a git repo", vim.log.levels.INFO)
  end

  vim.ui.input({
    prompt = "Diffview Baseline (Left revision): ",
  }, function(left)
    if not left or vim.trim(left) == "" then
      return
    end

    left = vim.trim(left)

    vim.schedule(function()
      vim.ui.input({
        prompt = string.format("Diffview Target (Right revision, defaults to HEAD vs %s): ", left),
        default = "HEAD",
      }, function(right)
        if not right then
          return
        end

        right = vim.trim(right)
        if right == "" then
          right = "HEAD"
        end

        -- Safe execution to catch invalid hashes without dumping a stack trace
        local ok, err =
          pcall(vim.api.nvim_command, string.format("DiffviewOpen %s..%s", left, right))
        if not ok then
          vim.notify("Diffview failed: " .. tostring(err), vim.log.levels.ERROR)
        end
      end)
    end)
  end)
end, {
  desc = "Open Diffview between two revisions",
})

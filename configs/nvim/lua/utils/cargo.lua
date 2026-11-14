local M = {}

-- per-manifest cache: repeated launches skip `cargo metadata`
local cache = {}

local function manifest()
  local found = vim.fs.find("Cargo.toml", {
    path = vim.fn.getcwd(),
    upward = true,
    type = "file",
  })[1]

  if not found then
    vim.notify("no Cargo.toml found above " .. vim.fn.getcwd(), vim.log.levels.WARN)
  end

  return found
end

local function metadata(manifest_path)
  local cmd = { "cargo", "metadata", "--no-deps", "--format-version", "1" }
  vim.list_extend(cmd, { "--manifest-path", manifest_path })

  local out = vim.system(cmd, { text = true }):wait()

  if out.code ~= 0 then
    vim.notify("cargo metadata failed:\n" .. vim.trim(out.stderr or ""), vim.log.levels.ERROR)
    return nil
  end

  local ok, data = pcall(vim.json.decode, out.stdout)
  if not ok then
    vim.notify("could not parse cargo metadata output", vim.log.levels.ERROR)
    return nil
  end

  return data
end

local function bins()
  local manifest_path = manifest()
  if not manifest_path then
    return nil
  end

  if cache[manifest_path] then
    return cache[manifest_path]
  end

  local data = metadata(manifest_path)
  if not data then
    return nil
  end

  local cwd = vim.fn.getcwd()
  local found = {}
  for _, pkg in ipairs(data.packages or {}) do
    local pkg_dir = vim.fs.dirname(pkg.manifest_path)

    if cwd == pkg_dir or vim.startswith(cwd, pkg_dir .. "/") then
      for _, target in ipairs(pkg.targets or {}) do
        if vim.tbl_contains(target.kind, "bin") then
          table.insert(found, {
            name = target.name,
            src_path = target.src_path,
            default = target.src_path == pkg_dir .. "/src/main.rs",
            path = vim.fs.joinpath(data.target_directory, "debug", target.name),
          })
        end
      end
    end
  end

  cache[manifest_path] = found
  return found
end

--- Current buffer's bin, else the package's default bin, else the only one.
--- @return string|nil
function M.find_bin()
  local found = bins()
  if not found then
    return nil
  end

  if #found == 0 then
    vim.notify("cargo: no bin target in this package", vim.log.levels.WARN)
    return nil
  end

  local current = vim.api.nvim_buf_get_name(0)
  for _, bin in ipairs(found) do
    if current ~= "" and bin.src_path == current then
      return bin.path
    end
  end

  for _, bin in ipairs(found) do
    if bin.default then
      return bin.path
    end
  end

  if #found == 1 then
    return found[1].path
  end

  local names = vim.tbl_map(function(bin)
    return bin.name
  end, found)
  vim.notify(
    "cargo: ambiguous bin targets (" .. table.concat(names, ", ") .. "), open one of their sources",
    vim.log.levels.WARN
  )

  return nil
end

--- Blocking: nvim-dap needs the binary on disk before it launches.
--- @return boolean
function M.build()
  local manifest_path = manifest()
  if not manifest_path then
    return false
  end

  vim.notify("cargo build", vim.log.levels.INFO)

  local cwd = vim.fs.dirname(manifest_path)
  local out = vim.system({ "cargo", "build" }, { cwd = cwd, text = true }):wait()

  if out.code ~= 0 then
    vim.notify("cargo build failed:\n" .. vim.trim(out.stderr or ""), vim.log.levels.ERROR)
    return false
  end

  cache = {}
  return true
end

return M

-- thin wrapper of hl.bind - allow array of keys

---@param keys string|string[]
---@param dispatcher function|HL.Dispatcher
---@param opts? HL.BindOptions
---@return HL.Keybind[]
local bind = function(keys, dispatcher, opts)
  if type(keys) == "string" then
    keys = { keys }
  end

  local binds = {}

  for _, key in ipairs(keys) do
    binds[#binds + 1] = hl.bind(key, dispatcher, opts)
  end

  return binds
end

return bind

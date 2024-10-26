local M = {}

---@class nixCatsSetupOpts
---@field non_nix_value boolean|nil

---allows you to guarantee a boolean is returned
---@overload fun(v: string|string[]): boolean
---@overload fun(v: string|string[], default: boolean): boolean
function M.enableForCategory(v, default)
  if default == nil then
    if nixCats(v) then
      return true
    else
      return false
    end
  else
    return default
  end
end

return M

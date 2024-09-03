
local debug_getinfo = debug.getinfo

noop = function() 

end 




lib = setmetatable({
  name = 'clean_lib',
  context = IsDuplicityVersion() and 'server' or 'client',
}, {
  __newindex = function(self,key,fn)
    rawset(self,key,fn)

    if debug_getinfo(2, 'S').short_src:find('@clean_lib/src') then
      exports(key, fn)
    end
  end,

  __index = function(self,key)
    local dir = ('modules/%s'):format(key)
    local chunk = LoadResourceFile(self.name, ('%s/%s.lua'):format(dir, self.context))
    local shared = LoadResourceFile(self.name, ('%s/shared.lua'):format(dir))

    if shared then 
      chunk = (chunk and ('%s\n%s'):format(shared, chunk)) or shared
    end

    if chunk then 
      local fn, err = load(chunk, ('@@clean_lib/modules/%s/%s.lua'):format(key, self.context))

      if not fn or err then 
        return error(('Error loading module %s: %s'):format(key, err or 'unknown error'))
      end

      local result = fn()
      self[key] = result or noop
      return self[key]
    end
  end
})

--## Override require with ox's lovely require module
require = lib.require


--## FRAMEWORK/SETTINGS
local settings = require 'src.settings'
lib.settings = settings

local getFrameworkObject = function()
  if settings.framework == 'qb-core' or settings.framework == 'qbx_core' then 
    return exports['qb-core']:GetCoreObject()
  elseif settings.framework == 'es_extended' then
    return exports['es_extended']:getSharedObject()
  end
end

lib.FW = setmetatable({}, {
	__index = function(self, index)
		local fw_obj = getFrameworkObject()
		return fw_obj[index]
	end
})
cache = {
  resource = GetCurrentResourceName(), 
  game     = GetGameName(),
}

local poolNatives = {
  CPed = GetAllPeds,
  CObject = GetAllObjects,
  CVehicle = GetAllVehicles,
}

local GetGamePool = function(poolName)
  local fn = poolNatives[poolName]
  return fn and fn() --[[@as number[] ]]
end
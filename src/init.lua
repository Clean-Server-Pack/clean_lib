

local debug_getinfo = debug.getinfo

noop = function() 

end 




lib = setmetatable({
  name = 'clean_lib',
  context = IsDuplicityVersion() and 'server' or 'client',
  settings = settings,

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
  if settings.framework == 'qb-core' or setings.framework == 'qbx_core' then 
    print('GETTING QB CORE')
    return exports[settings.framework]:GetCoreObject()
  elseif settings.framework == 'es_extended' then
    return exports['es_extended']:getSharedObject()
  end
end

print('TESTING', settings.framework)
lib.print.error('TESTING', settings.framework)


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


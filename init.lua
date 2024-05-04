
if not _VERSION:find('5.4') then 
  error("This library is only compatible with Lua 5.4")
end

local resource_name = GetCurrentResourceName()
local dirk_lib = 'dirk_lib'

if lib and lib.name == 'dirk_lib' then
  error(('Cannot load dirk_lib more than once.\nRemove any duplicated versions from %s fxmanifest.lua'):format(resource_name))
end

if GetResourceState(dirk_lib) ~= 'started' then
  error(('dirk_lib is not started. Make sure it is started before %s in your server.cfg'):format(resource_name))
end



local LoadResourceFile = LoadResourceFile
local context       = IsDuplicityVersion() and 'server' or 'client'

local noop = function() end

local load_module = function(self,module)
  local dir   = ('modules/%s'):format(module)
  local chunk = LoadResourceFile(dirk_lib, ('%s/%s.lua'):format(dir, context))
  local shared = LoadResourceFile(dirk_lib, ('%s/shared.lua'):format(dir))

  print('Path is ', ('%s/%s.lua'):format(dir, context))

  if shared then 
    chunk = (chunk and ('%s\n%s'):format(shared, chunk)) or shared
  end

  if chunk then 
    local fn, err = load(chunk, ('@@dirk_lib/modules/%s/%s.lua'):format(module, context))

    if not fn or err then 
      return error(('Error loading module %s: %s'):format(module, err or 'unknown error'))
    end

    local result = fn()
    self[module] = result or noop
    return self[module]
  end
end

local call = function(self, index, ...)
  local module = rawget(self, index)
  if not module then 
    self[index] = noop
    module = load_module(self,index)

    if not module then 
      return error(('Module %s does not exist'):format(index))
    end
  end
  return module 
end

local lib = setmetatable({
  name = dirk_lib, 
  context = context,
  onCache = function(key, cb)
    AddEventHandler(('dirk_lib:cache:%s'):format(key), cb)
  end,
}, {
  __index = call, 
  __call  = call
})

_ENV.lib = lib





SetInterval = function(cb, ms, reps)
  local id = SetTimeout(function()
    cb()
    if reps then 
      reps = reps - 1
      if reps == 0 then 
        ClearInterval(id)
      end
    end
  end, ms)
  return id
end

ClearInterval = function(id)
  ClearTimeout(id)
end

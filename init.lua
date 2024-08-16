
if not _VERSION:find('5.4') then 
  error("This library is only compatible with Lua 5.4")
end

local resource_name = GetCurrentResourceName()
local clean_lib = 'clean_lib'
local export = exports[clean_lib]

if lib and lib.name == 'clean_lib' then
  error(('Cannot load clean_lib more than once.\nRemove any duplicated versions from %s fxmanifest.lua'):format(resource_name))
end

if GetResourceState(clean_lib) ~= 'started' then
  error(('clean_lib is not started. Make sure it is started before %s in your server.cfg'):format(resource_name))
end

local LoadResourceFile = LoadResourceFile
local context       = IsDuplicityVersion() and 'server' or 'client'

local noop = function() end

local load_module = function(self,module)
  local dir   = ('modules/%s'):format(module)
  local chunk = LoadResourceFile(clean_lib, ('%s/%s.lua'):format(dir, context))
  local shared = LoadResourceFile(clean_lib, ('%s/shared.lua'):format(dir))


  if shared then 
    chunk = (chunk and ('%s\n%s'):format(shared, chunk)) or shared
  end

  if chunk then 
    local fn, err = load(chunk, ('@@clean_lib/modules/%s/%s.lua'):format(module, context))

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
    

      local function method(...)
        return export[index](nil, ...)
      end

      if not ... then
        self[index] = method
      end

      return method
    end
  end
  return module 
end

local lib = setmetatable({
  name = clean_lib, 
  context = context,
  onCache = function(key, cb)
    AddEventHandler(('clean_lib:cache:%s'):format(key), cb)
  end,

  settings = {
    server_name     = 'CleanRP',
    framework       = 'qb-core',
    inventory       = 'ox_inventory',
    target          = 'ox_target',
    
    
    keys            = 'ox_keys',
    jail            = 'ox_jail',
    time            = 'clean_weather', 
    progress        = 'clean_lib',
    phone           = 'lb-phone', 
    fuel            = 'ox_fuel',
    dispatch        = 'ox_dispatch',

    primaryColor    = 'clean',
    secondaryColor  = 'clean',
    logo            = 'https://via.placeholder.com/150' 
  }
}, {
  __index = call, 
  __call  = call
})

_ENV.lib = lib

local cache = setmetatable({
  resource = resource_name,
  game     = GetGameName(),
}, {
  __index = context == 'client' and function(self, key)
    AddEventHandler(('clean_lib:cache:%s'):format(key), function(value, old_value)
      self[key] = value
    end)

    return rawset(self,key,export.cache(nil,key) or false)[key]
  end or nil,

  __call = function(self, key, value)
    local value = rawget(self,key)

    if not value then 
      value = func()

      rawset(self,key,value)

      if timeout then SetTimeout(timeout,function() self[key] = nil; end) end 
    end

    return value
  end


})

if lib.settings.framework == 'qb-core' then 
  QBCore = exports['qb-core']:GetCoreObject()
elseif lib.settings.framework == 'es_extended' then
  ESX = exports['es_extended']:getSharedObject()
end

_ENV.cache = cache

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



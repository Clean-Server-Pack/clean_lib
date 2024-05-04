noop = function() 

end 

lib = setmetatable({
  name = 'dirk_lib',
  context = IsDuplicityVersion() and 'server' or 'client',
}, {
  __newindex = function(self,key,fn)
    rawset(self,key,fn)
  end,

  __index = function(self,key)
    local dir = ('modules/%s'):format(key)
    local chunk = LoadResourceFile(self.name, ('%s/%s.lua'):format(dir, self.context))
    local shared = LoadResourceFile(self.name, ('%s/shared.lua'):format(dir))

    if shared then 
      chunk = (chunk and ('%s\n%s'):format(shared, chunk)) or shared
    end

    if chunk then 
      local fn, err = load(chunk, ('@@dirk_lib/modules/%s/%s.lua'):format(key, self.context))

      if not fn or err then 
        return error(('Error loading module %s: %s'):format(key, err or 'unknown error'))
      end

      local result = fn()
      self[key] = result or noop
      return self[key]
    end
  end
})


cache = {
  resource = GetCurrentResourceName(), 
  game     = GetGameName(),
}
local syncZone = {}
syncZone.__index = syncZone

syncZone.new = function(id,data)
  local self = setmetatable(data, syncZone)
  self.id = id
  syncZone[id] = self
  self:__init()
  return self
end 

function syncZone:__init()
  assert(self.type and self.type == 'poly' or self.type == 'game', 'Invalid Zone Type')
  assert(self.type == 'poly' and self.zone and type(self.zone) == 'table', 'Invalid Zone Data for Poly')
  assert(self.type == 'game' and self.zone and type(self.zone) == 'string', 'Invalid Zone Data for Game')

  lib.zones.register(('SyncZone:%s', self.id), {
    type = self.type, 
    
  })
end

lib.sync = {
  addZone = function(id,data)
    return syncZone.new(id,data)
  end, 

  addZoneHandler = function(id,handler)
    AddEventHandler(('clean_lib:sync:syncInZone'..id),handler)
  end,
}

return lib.sync

-- Client Usage 
--[[

  -- Register The Zone 
  lib.sync.addZone('zone1', {
    type = 'poly', 
    zone = {
      {x = 0, y = 0},
      {x = 0, y = 10},
      {x = 10, y = 10},
      {x = 10, y = 0},
    }, 
  })


  -- Add Event Handler 
  lib.sync.addZoneHandler('zone1',function(myarg1, myarg2)
    print(myarg1, myarg2)
  end)
]]


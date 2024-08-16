
-- server 
local syncZone = {}
syncZone.__index = syncZone

syncZone.new = function(id,data)
  local self = setmetatable(data, syncZone)
  self.id = id
  self:__init()
  syncZone[id] = self
  return self
end

function syncZone:__init()
  self.in_zone = {}
  AddEventHandler(('clean_lib:sync:enterZone:'..self.id),function(player)
    self.in_zone[player] = true
  end)

  AddEventHandler(('clean_lib:sync:leaveZone:'..self.id),function(player)
    self.in_zone[player] = nil
  end)

  AddEventHandler('playerDropped',function(src,reason)
    if self.in_zone[src] then
      self.in_zone[src] = nil
    end
  end)
end

function syncZone:sendToClients(...)
  for k,v in pairs(self.in_zone) do
    TriggerClientEvent(('clean_lib:sync:syncInZone'..self.id),v, ...)
  end
  return true
end


lib.sync = {
  addZone = function(id,data)
    return syncZone.new(id,data)
  end, 

  syncZone = function(id,...)
    local zone = syncZone[id]
    assert(zone,'Zone not found')
    return zone:sendToClients(...)
  end,
}

-- Server Usage 


-- -- Register The Zone 
-- lib.sync.addZone('zone1', {})

-- -- Sync Data To Clients 
-- lib.sync.syncZone('zone1', myarg1, myarg2)

return lib.sync


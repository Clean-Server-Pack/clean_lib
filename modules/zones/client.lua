local zones = {}
local zone = {}
zone.__index = zone

zone.new = function(id,data)
  local self = setmetatable(data, zone)
  self.id = id
  zones[id] = self
  self:__init()
  return self
end

zone.get = function(id)
  return zones[id]
end

zone.delete = function(id)
  zones[id] = nil
end

function zone:__init()
  assert(self.type, 'zone must have a specified type : circle, circle2D, poly, box, game_zone, all_game_zone')


  if self.type == 'circle' then 
    assert(self.pos, 'circle zone must have a position')
    assert(self.radius, 'circle zone must have a radius')
    self.center_pos = self.pos
  end

  if self.type == 'circle2D' then 
    assert(self.pos, 'circle2D zone must have a position with atleast an x and y value')
    assert(self.radius, 'circle2D zone must have a radius')
    self.center_pos = self.pos
  end


  if self.type == 'poly' then 
    assert(self.points, 'poly zone must have points')
    self.polygon = glm.polygon.new(self.points)
    self.height = self.height or 5.0
    self.center_pos = lib.zones.getCenter(self.points)
  end

  if self.type == 'box' then 
    assert(self.pos, 'box zone must have a position')
    assert(self.size, 'box zone must have a size')
    self.center_pos = self.pos + self.size / 2
  end

  if self.type == 'game_zone' then 
    assert(self.game_zone, 'game_zone must have a game_zone')
  end

  if self.type == 'all_game_zone' then 
    assert(self.onChange, 'all_game_zone must have some sort of onChange function or its useless you squirt')
  end

  if self.center_pos then 
    self.chunk_zone = GetNameOfZone(self.center_pos.x, self.center_pos.y, self.center_pos.z)
  end
  -- lib.print.debug(('zone %s has been created n chunkZone %s'):format(self.id, self.chunk_zone))
  return self
end




function zone:is_inside(data)
  local dist = #(data.pos - self.center_pos.xyz)
  local current_pos = data.pos 

  if self.type == 'circle2D' then 
    return #(current_pos.xy - self.pos.xy) <= self.radius
  elseif self.type == 'circle' then
    return dist <= self.radius
  elseif self.type == 'poly' then
    return self.polygon:contains(current_pos.xyz, self.height)
  elseif self.type == 'game_zone' then 
    return self.game_zone == GetNameOfZone(pos.x, pos.y, pos.z)
  elseif self.type == 'box' then 
    return current_pos.x >= self.pos.x and current_pos.x <= self.pos.x + self.size.x and current_pos.y >= self.pos.y and current_pos.y <= self.pos.y + self.size.y and current_pos.z >= self.pos.z and current_pos.z <= self.pos.z + self.size.z
  end
  return false
end

function zone:enter(data)
  if self.inside then return false; end   
  self.inside = true
  if self.onEnter then 

    self.onEnter(data)


  end
end

function zone:exit(data)
  if not self.inside then return false; end
  self.inside = false
  if self.onExit then 
    self.onExit(data)
  end
end

function zone:handleGameZone(current_zone)
  if self.last_zone and self.last_zone == current_zone then return; end 
  self.last_zone = current_zone
  self.onChange(current_zone)
end

function zone:draw(data)
  if not self.drawZone then return false; end
  local distance_to_center = #(data.pos - self.center_pos.xyz)
  if distance_to_center > 50.0 then return false; end
  if self.type == 'circle' or self.type == 'circle2D' then 
    local circle = self.type == 'circle' 
    DrawMarker(1, 
      self.pos.x, 
      self.pos.y, 
      circle and (self.pos.z - 1.0) or 0.0, 
      0, 
      0, 
      0, 
      0, 
      0, 
      0, 
      self.radius * 2, 
      self.radius * 2, 
      circle and (self.radius * 2) or 5000.0, 
      255, 
      0, 
      0, 
      200, 
      0, 
      0, 
      0, 
      0)
  elseif self.type == 'poly' then

  elseif self.type == 'box' then 

  end
  return true 
end

CreateThread(function()
  while true do
    local wait_time = 1000
    local ply = cache.ped
    local my_pos = GetEntityCoords(ply)
    local gta_zone = GetNameOfZone(my_pos)
    local current_state = {
      pos = my_pos,
      game_zone = gta_zone
    }

    for name, data in pairs(zones) do
      if data.type == 'all_game_zone' then 
        data:handleGameZone(current_state.game_zone)
      end

      if data.chunk_zone then 
        if data.chunk_zone == gta_zone then 
          wait_time = data:draw(current_state) and 0 or wait_time
          local is_inside = data:is_inside(current_state)
          if is_inside then 
            data:enter(current_state)
            if data.onInside then 
              data.onInside(current_state)
            end
          else 
            data:exit(current_state)
          end
        else 
          data:exit(current_state)
        end
      end 
    end
    
    Wait(wait_time)
  end
end)



lib.zones = {
  register = function(name, data)
    return zone.new(name, data)
  end,

  get = function(name)
    return zone.get(name)
  end,

  delete = function(name)
    return zone.delete(name)
  end,

  destroy = function(name)
    return zone.delete(name)
  end,

  getCenter = function(poly)
    
  end,

  polyPointCheck = function(poly, coord)
    return glm.polygon.new(poly):contains(coord)
  end
}

return lib.zones
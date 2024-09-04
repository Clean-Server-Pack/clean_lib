local Markers = {}

Marker  = {}
Marker.__index = Marker

Marker.new = function(id, data)
  local self = setmetatable(data, Marker)
  self.id = id
  if not self:__init() then return false; end 
  Markers[id] = self
  return self
end

Marker.get = function(id)
  return Markers[id]
end

Marker.delete = function(id)
  Markers[id] = nil
end

Marker.destroy = function(id)
  Marker.delete(id)
end


function Marker:draw3DText()

end

function Marker:drawMarker()
  if not self.inside then return end
  self:draw3DText( self.text )
  DrawMarker(self.marker, self.pos.x, self.pos.y, self.pos.z, 0, 0, 0, 0, 0, 0, self.size?.x or 1.0, self.size?.y or 1.0, self.size?.z or 1.0, self.color?.r or 0, self.color?.g or 200, self.color?.b or 0, self.color?.a or 155, false, false, 2, false, false, false, false)
  return true 
end

CreateThread(function()
  while true do 
    local wait_time = 1000

    for name, data in pairs(Markers) do
      if data.type == 'circle' then 
        if data:drawMarker() then 
          wait_time = 0
        end 
      end
    end

    Wait(wait_time)
  end
end)

function Marker:__init()
  assert(self.pos, 'marker must have a position')
  assert(self.radius, 'marker must have a radius')
  assert(self.marker, 'marker must have a marker type')
  lib.zones.register(self.id, {
    type   = 'circle', 
    pos    = self.pos,
    radius = self.renderDist,
    onEnter  = function()
      self.inside = true
      self:drawMarker()
    end

    onExit   = function()
      self.inside = false
    end
  })
  return true
end

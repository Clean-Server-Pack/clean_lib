local Waypoints = {}
local Waypoint  = {}
Waypoint.__index = Waypoint

Waypoint.register = function(id,data)
  local self = setmetatable(data, Waypoint)
  self:__init()
  Waypoints[id] = self
  return self
end   
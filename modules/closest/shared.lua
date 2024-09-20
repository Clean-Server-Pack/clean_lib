local context = IsDuplicityVersion() and 'server' or 'client'

local pool_types = {
  player = 'CPed',
  ped    = 'CPed',
  vehicle = 'CVehicle',
  object = 'CObject',
}

local default_conditions = {
  player = function(entity)
    return IsPedAPlayer(entity)
  end,

  ped = function(entity)
    return not IsPedAPlayer(entity)
  end,
}


local index_ignores = function(tbl)
  local indexed_ignore = {}
  if tbl then 
    for i=1, #ignore do
      indexed_ignore[ignore[i]] = true
    end
  end
  return indexed_ignore
end 
-- This will return all within a range of a position
local getAllWithinRange = function(_type, pos, range, ignore, condition)
  assert(pool_types[_type], 'Invalid type | Valid: player, ped, vehicle, object')
  assert(context == 'client' or pos, 'Position is required on server side')
  assert(not pos or (type(pos) == 'vector3' or type(pos) == 'vector4' or type(pos) == 'vector2'), 'Position must be a vector3 or vector4 or vector2')
  assert(not range or type(range) == 'number', 'Range must be a number')
  local indexed_ignore = index_ignores(ignore)
  pos = pos or GetEntityCoords(cache.ped)
  local pool = pool_types[_type]
  local player = context == 'client' and cache.ped
  local entities = GetGamePool(pool)
  local foundEntities = {}
  local distances  = {}
  for i=1, #entities do
    local entity = entities[i]
    local ent_coords = GetEntityCoords(entity)
    local dist = pos.z and #(pos.xyz - ent_coords) or #(pos.xy - ent_coords.xy) 
    if not indexed_ignore[entity] then
      if context == 'server' or entity ~= player then 
        if not range or dist < range then
          local met_conditions = not default_conditions[_type] or default_conditions[_type](entity)
          if met_conditions then
            if not condition or condition(entity) then
              table.insert(foundEntities, entity)
              distances[entity] = dist
            end 
          end
        end 
      end
    end
  end
  return foundEntities, distances
end 

local getClosestOfType = function(_type, pos, range, ignore, condition)
  assert(pool_types[_type], 'Invalid type | Valid: player, ped, vehicle, object')
  assert(context == 'client' or pos, 'Position is required on server side')
  assert(not pos or (type(pos) == 'vector3' or type(pos) == 'vector4' or type(pos) == 'vector2'), 'Position must be a vector3 or vector4 or vector2')
  assert(not range or type(range) == 'number', 'Range must be a number')
  local indexed_ignore = index_ignores(ignore)
  pos = pos or GetEntityCoords(cache.ped)
  local pool = pool_types[_type]
  local player = context == 'client' and cache.ped
  local entities, distances = getAllWithinRange(_type, pos, range, ignore, condition)
  local closestEntity, closestDistance = nil, nil
  for i=1, #entities do
    local entity = entities[i]
    local dist = distances[entity]
    if not closestDistance or dist < closestDistance then
      closestEntity = entity
      closestDistance = dist
    end
  end
  return closestEntity, closestDistance
end

lib.closest = {}

lib.closest.all = {}

setmetatable(lib.closest.all, {
  __index = function(self, index)
    return function(...)
      return getAllWithinRange(index, ...)
    end
  end
})


-- Useage example:
-- local allPeds, distances = lib.closest.all.ped()
-- local allPeds, distances = lib.closest.all.ped(vector3(0,0,0), 100.0)
-- local allPeds, distances = lib.closest.all.ped(vector3(0,0,0), 100.0, function(ped) return ped ~= cache.ped end)
-- local allPeds, distances = lib.closest.all.ped(vector3(0,0,0), 100.0, function(ped) return ped ~= cache.ped end, function(ped) return ped end)
-- local allPeds, distances = lib.closest.all.ped(vector3(0,0,0), 100.0, function(ped) return ped ~= cache.ped end, function(ped) return ped, #(GetEntityCoords(ped) - vector3(0,0,0)) end)

setmetatable(lib.closest, {
  __index = function(self, index)
    return function(...)
      return getClosestOfType(index, ...)
    end
  end
})

-- Useage example:
-- local closestPed, distance = lib.closest.ped() 
-- local closestPed, distance = lib.closest.ped(vector3(0,0,0), 100.0)
-- local closestPed, distance = lib.closest.ped(vector3(0,0,0), 100.0, function(ped) return ped ~= cache.ped end)
-- local closestPed, distance = lib.closest.ped(vector3(0,0,0), 100.0, function(ped) return ped ~= cache.ped end, function(ped) return ped end)
-- local closestPed, distance = lib.closest.ped(vector3(0,0,0), 100.0, function(ped) return ped ~= cache.ped end, function(ped) return ped, #(GetEntityCoords(ped) - vector3(0,0,0)) end)

return lib.closest

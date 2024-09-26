local settings = lib.settings

local parse_options_for_ox = function(opts)
  for k,v in pairs(opts) do 
    opts[k].onSelect = v.action
  end
  return opts
end


local created_zones = {}

lib.target = {
  box = function(id,data)

    assert(data.pos, 'Missing position')
    assert(data.height, 'Missing height')
    assert(data.options, 'Missing options')
    -- assert(data.length, 'Missing length')
    -- assert(data.width, 'Missing width')
    -- assert(data.distance, 'Missing distance')


    if settings.target == 'qb-target' or settings.target == 'qtarget' then 
      exports[settings.target]:AddBoxZone(id, vector3(data.pos.x, data.pos.y, data.pos.z), (data.length or 1.0), (data.width or 1.0), {
        name      = id, -- This is the name of the zone recognized by PolyZone, this has to be unique so it doesn't mess up with other zones
        debugPoly = data.debug, -- This is for enabling/disabling the drawing of the box, it accepts only a boolean value (true or false), when true it will draw the polyzone in green
        heading   = (data.pos.w or 0.0),
        minZ      = data.pos.z - 1.0,
        maxZ      = data.pos.z + data.height,
      }, {
        options = data.options,
        distance = (data.distance or 1.5), -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
      })
    elseif settings.target == 'ox_target' then 
      local opts = parse_options_for_ox(data.options)
      local newTarget = exports[settings.target]:addBoxZone({
        coords = vector3(data.pos.x, data.pos.y, data.pos.z),
        size = vector3((data.length or 1.0), (data.width or 1.0), (data.height or 1.0)),
        rotation = data.pos.w,
        debug = data.debug,
        options = data.options,
      })
      created_zones[id] = newTarget
    end
  end,


  polyzone = function(id,data)
    assert(data.polygon, 'Missing polygon')
    assert(data.height, 'Missing height')
    assert(data.options, 'Missing options')
    

    local temp_target_system = nil
    if settings.target == "qb-target" or settings.target == "qtarget" or settings.target == "ox_target" then
      if settings.target == "ox_target" then temp_target_system = "qb-target" else temp_target_system = settings.target;  end
      local minZ = 999999999
      for k,v in pairs(data.polygon) do 
        data.polygon[k] = vector2(v.x, v.y)
        if v.z <= minZ then minZ = v.z; end
      end

      for k,v in pairs(data.options) do 
        if not v.distance then v.distance = (data.distance or 1.5); end
      end
      
      local zone = exports[tempTargetSystem]:AddPolyZone(name, data.polygon, {
        name = name, -- This is the name of the zone recognized by PolyZone, this has to be unique so it doesn't mess up with other zones
        debugPoly = data.debug, -- This is for enabling/disabling the drawing of the box, it accepts only a boolean value (true or false), when true it will draw the polyzone in green
        minZ = minZ, -- This is the bottom of the polyzone, this can be different from the Z value in the coords, this has to be a float value
        maxZ = minZ + data.height, -- This is the top of the polyzone, this can be different from the Z value in the coords, this has to be a float value
      }, {
        options = data.options,
        distance = data.distance or 1.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
      })

      created_zones[name] = zone
      return name
    end
  end, 


  removeZone = function(id)
    assert(id, 'Missing id')
    if settings.target == "qb-target" or settings.target == "q-target" then
      exports[settings.target]:RemoveZone(id)
    elseif settings.target == "ox_target" then
      exports[settings.target]:removeZone(tonumber(created_zones[id]))
    end
  end,

  entity = function(entity,data)
    assert(data.options, 'Missing options')
    assert(data.distance, 'Missing distance')

    if settings.target == "qb-target" or settings.target == "qtarget" then
      exports[settings.target]:AddTargetEntity(entity, {
        options = data.options,
        distance = (data.distance or 1.5)
      })
    elseif settings.target == "ox_target" then
      local opts = parse_options_for_ox(data.options)
      if data.networked then
        return exports[settings.target]:addEntity(entity, opts)
      else
        return exports[settings.target]:addLocalEntity(entity, opts)
      end
    end
  end,

  removeEntity = function(entity, net)
    assert(entity, 'Missing entity')
    if settings.target == "qb-target" or settings.target == "qtarget" then
      exports[settings.target]:RemoveTargetEntity(entity)
    elseif settings.target == "ox_target" then
      if net then
        exports.ox_target:removeEntity(entity)
      else
        exports.ox_target:removeLocalEntity(entity)       
      end
    end
  end,

  addModels = function(data)
    if settings.target == "qb-target" or settings.target == "qtarget" then
      exports[settings.target]:AddTargetModel(data.models, {
        distance = (data.distance or 1.5),
        options  = data.options,
      })
    elseif settings.target == "ox_target" then
      return exports.ox_target:addModel(data.models, parse_options_for_ox(data.options))
    end
  end, 

  addGlobalVehicle = function(data)
    if settings.target == "qb-target" then 
      exports[settings.target]:AddGlobalVehicle({
        options = data.options,
        distance = (data.distance or 1.5),
      })
    elseif settings.target == "qtarget" then
      exports[settings.target]:Vehicle({
        options = data.options,
        distance = (data.distance or 1.5),
      })
    elseif settings.target == "ox_target" then
      return exports.ox_target:addGlobalVehicle(parse_options_for_ox(data.options))
    end
  end,
  

  addGlobalPed = function(data)
    if settings.target == "qb-target" then 
      exports[settings.target]:AddGlobalPed({
        options = data.options,
        distance = (data.distance or 1.5),
      })
    elseif settings.target == "qtarget" then
      exports[settings.target]:Ped({
        options = data.options,
        distance = (data.distance or 1.5),
      })
    elseif settings.target == "ox_target" then
      return exports.ox_target:addGlobalPed(parse_options_for_ox(data.options))
    end
  end,


  addGlobalPlayer = function(data)
    if settings.target == "qb-target" then 
      exports[settings.target]:AddGlobalPlayer({
        options = data.options,
        distance = (data.distance or 1.5),
      })
    elseif settings.target == "qtarget" then
      exports[settings.target]:Player({
        options = data.options,
        distance = (data.distance or 1.5),
      })
    elseif settings.target == "ox_target" then
      return exports.ox_target:addGlobalPlayer(parse_options_for_ox(data.options))
    end
  end,
}

return lib.target
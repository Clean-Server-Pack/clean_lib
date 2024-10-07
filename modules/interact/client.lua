local settings = lib.settings
local parseOptions = function(options)
  for k,v in pairs(options) do 
    if v.action then 
      v.onSelect = v.action
    end 
  end
  return options
end


lib.interact = {
  entity = function(entity, data)
    if settings.interact == 'sleepless_interact' then
      local interact_data = {
        id = ('entity_%s'):format(entity), 
        entity = entity, 
        -- netId  = data.network and entity or nil, 
        options = parseOptions(data.options),
        renderDistance = data.renderDistance or 10.0,
        activeDistance = data.distance       or 1.5,
        cooldown       = data.cooldown       or 1500,
      }
      if data.network then 
        exports.sleepless_interact:addEntity(interact_data)
      else
        exports.sleepless_interact:addLocalEntity(interact_data)
      end
        
    elseif settings.interact == 'marker' then 

    end 
  end,

  addModels = function(data)
    -- print('rawOptionns', json.encode(data.options, {indent = true}))
    if settings.interact == 'sleepless_interact' then
      local interact_data = {
        id = ('model_%s'):format(data.model),
        models = data.models, 
        model  = #data.models == 1 and data.models[1] or nil,
        options = parseOptions(data.options),
        renderDistance = data.renderDistance or 10.0,
        activeDistance = data.distance       or 1.5,
        cooldown       = data.cooldown       or 1500,
      }
      -- print('options', json.encode(interact_data.options, {indent = true}))
      exports.sleepless_interact:addGlobalModel(interact_data)
    elseif settings.interact == 'marker' then 

    end 
  end, 

  addGlobalVehicle = function(vehicle, data)
    if settings.interact == 'sleepless_interact' then
      local options = {
        id = ('vehicle_%s'):format(vehicle), 
        vehicle = vehicle, 
        options = parseOptions(data.options),
        renderDistance = data.renderDistance or 10.0,
        activeDistance = data.distance       or 1.5,
        cooldown       = data.cooldown       or 1500,
      }
      if data.network then 
        exports.sleepless_interact.addVehicle(options)
      else
        exports.sleepless_interact.addLocalVehicle(options)
      end
        
    elseif settings.ineract == 'marker' then 

    end 
  end,

  addCoords = function(data)
    if settings.interact == 'sleepless_interact' then
      local interact_data = {
        id = ('coords_%s'):format(data.coords), 
        coords = vector3(data.coords.x, data.coords.y, data.coords.z), 
        options = parseOptions(data.options),
        renderDistance = data.renderDistance or 10.0,
        activeDistance = data.distance       or 1.5,
        cooldown       = data.cooldown       or 1500,
      }
      exports.sleepless_interact:addCoords(interact_data)
    elseif settings.interact == 'marker' then 

    end
  end,


  addGlobalPed = function(data)
    if settings.interact == 'sleepless_interact' then
      local interact_data = {
        id = data.id or ('ped_%s'):format(math.random(1, 1000000)), 
        options = parseOptions(data.options),
        renderDistance = data.renderDistance or 10.0,
        activeDistance = data.distance       or 1.5,
        cooldown       = data.cooldown       or 1500,
      }
  
      exports.sleepless_interact.addGlobalPed(interact_data)
    elseif settings.interact == 'marker' then 

    end 
  end,


  removeById = function(id)
    if settings.interact == 'sleepless_interact' then
      exports.sleepless_interact:removeById(id)
    elseif settings.interact == 'marker' then 

    end 
  end,

  removeEntity = function(entity)
    if settings.interact == 'sleepless_interact' then
      exports.sleepless_interact:removeEntity(entity)
    elseif settings.interact == 'marker' then 

    end 
  end,

  removeGlobnlModel = function(model)
    if settings.interact == 'sleepless_interact' then
      exports.sleepless_interact:removeGlobalModel(model)
    elseif settings.interact == 'marker' then 

    end 
  end,

  removeGlobalPlayer = function(player)
    if settings.interact == 'sleepless_interact' then
      exports.sleepless_interact:removeGlobalPlayer(player)
    elseif settings.interact == 'marker' then 

    end 
  end,

  
}


return lib.interact
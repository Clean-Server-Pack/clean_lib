
local parseOptions = function(options)
  local opts = {}
  for k,v in pairs(options) do 
    if v.action then 
      v.onSelect = v.action
    end 
  end
  return opts
end


lib.interact = {
  addEntity = function(entity, data)
    if settings.interact == 'sleepless_interact' then
      local options = {
        id = ('entity_%s'):format(entity), 
        entity = entity, 
        options = parseOptions(data.options),
      }
      if data.local then 
        exports.sleepless_interact.addLocalEntity(options)
      else
        exports.sleepless_interact.addEntity(options)
      else 
        
    elseif settings.ineract == 'marker' then 

    end 
  end,

  addModels = function(models, data)
    if settings.interact == 'sleepless_interact' then
      local options = {
        id = ('model_%s'):format(data.model),
        models = models, 
        model  = #models == 1 and models[1] or nil,
        options = parseOptions(data.options),
      }
      exports.sleepless_interact.addGlobalModel(data)
    elseif settings.interact == 'marker' then 

    end 
  end, 

  addGlobalVehicle = function(vehicle, data)
    if settings.interact == 'sleepless_interact' then
      local options = {
        id = ('vehicle_%s'):format(vehicle), 
        vehicle = vehicle, 
        options = parseOptions(data.options),
      }
      if data.local then 
        exports.sleepless_interact.addLocalVehicle(options)
      else
        exports.sleepless_interact.addVehicle(options)
      else 
        
    elseif settings.ineract == 'marker' then 

    end 
  end,

  
}
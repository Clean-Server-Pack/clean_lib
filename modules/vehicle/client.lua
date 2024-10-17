local settings = lib.settings
local keys = lib.loadBridge('keys', settings.keys, 'client')
local fuel = lib.loadBridge('fuel', settings.fuel, 'client')

lib.vehicle = {
  addKeys = function(veh,plate)
    return keys.addKeys and keys.addKeys(veh,plate) or lib.print.error(('No bridge found for adding keys for %s'):format(settings.keys))
  end, 

  removeKeys = function(veh,plate)
    return keys.removeKeys and keys.removeKeys(veh,plate) or lib.print.error(('No bridge found for removing keys for %s'):format(settings.keys))
  end,

  setFuel = function(veh,val,_type)
    return fuel.setFuel and fuel.setFuel(veh,val,_type) or lib.print.error(('No bridge found for setting fuel for %s'):format(settings.fuel))
  end,

  getFuel = function(veh)
    return fuel.getFuel and fuel.getFuel(veh) or lib.print.error(('No bridge found for getting fuel for %s'):format(settings.fuel))
  end
}

return lib.vehicle
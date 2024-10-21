local settings = lib.settings
local keys = lib.loadBridge('keys', settings.keys, 'client')
local fuel = lib.loadBridge('fuel', settings.fuel, 'client')


local vehClasses = {
  [0] = "Compacts",
  [1] = "Sedans",
  [2] = "SUVs",
  [3] = "Coupes",
  [4] = "Muscle",
  [5] = "Sports Classics",
  [6] = "Sports",
  [7] = "Super",
  [8] = "Motorcycles",
  [9] = "Off-road",
  [10] = "Industrial",
  [11] = "Utility",
  [12] = "Vans",
  [13] = "Cycles",
  [14] = "Boats",
  [15] = "Helicopters",
  [16] = "Planes",
  [17] = "Service",
  [18] = "Emergency",
  [19] =  "Military",
  [20] = "Commercial",
  [21] = "Trains",
}

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
  end,

  getClass = function(veh)
    local vehClass = GetVehicleClass(veh)
    local labelClass = vehClasses[vehClass]
    return vehClass, labelClass
  end,
}

return lib.vehicle
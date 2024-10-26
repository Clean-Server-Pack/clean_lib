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
    if not keys.addKeys then return lib.print.error(('No bridge found for adding keys for %s'):format(settings.keys)) end 
    return keys.addKeys(veh,plate)
  end, 

  removeKeys = function(veh,plate)
    if not keys.removeKeys then return lib.print.error(('No bridge found for removing keys for %s'):format(settings.keys)) end
    return keys.removeKeys(veh,plate)
  end,

  setFuel = function(veh,val,_type)
    if not fuel.setFuel then return lib.print.error(('No bridge found for setting fuel for %s'):format(settings.fuel)) end
    return fuel.setFuel(veh,val,_type)
  end,

  getFuel = function(veh)
    if not fuel.getFuel then return lib.print.error(('No bridge found for getting fuel for %s'):format(settings.fuel)) end
    return fuel.getFuel(veh)
  end,

  getClass = function(veh)
    local vehClass = GetVehicleClass(veh)
    local labelClass = vehClasses[vehClass]
    return vehClass, labelClass
  end,
}

return lib.vehicle
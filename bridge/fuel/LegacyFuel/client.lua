return {
  setFuel = function(veh, val, _type)
    return exports['LegacyFuel']:SetFuel(veh)
  end, 

  getFuel = function(veh)
    return exports['LegacyFuel']:GetFuel(veh)
  end
}
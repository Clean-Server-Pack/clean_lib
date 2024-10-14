return {
  setFuel = function(veh, val, _type)
    return exports['Renewed-Fuel']:SetFuel(veh, val)
  end, 

  getFuel = function(veh)
    return exports['Renewed-Fuel']:GetFuel(veh)
  end
}
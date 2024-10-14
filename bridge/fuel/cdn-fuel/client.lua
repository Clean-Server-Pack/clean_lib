return {
  setFuel = function(veh, val, _type)
    return exports['cdn-fuel']:SetFuel(veh, val)
  end, 

  getFuel = function(veh)
    return exports['cdn_fuel']:GetFuel(veh)
  end
}
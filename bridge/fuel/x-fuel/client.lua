return {
  setFuel = function(veh, val, _type)
    return exports['x-fuel']:SetFuel(veh, val)
  end, 

  getFuel = function(veh)
    return exports['x-fuel']:GetFuel(veh)
  end
}
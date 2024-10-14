return {
  setFuel = function(veh, val, _type)
    return exports['ps-fuel']:SetFuel(veh, val)
  end, 

  getFuel = function(veh)
    return exports['ps-fuel']:GetFuel(veh, val)
  end
}
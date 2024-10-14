return {
  setFuel = function(veh, val, _type)
    return Entity(veh).state.fuel += val 
  end, 

  getFuel = function(veh)
    return Entity(veh).state.fuel
  end
}
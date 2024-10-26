return {
  setFuel = function(veh, val, _type)
    return exports["ti_fuel"]:setFuel(veh, val, _type or "RON91")
  end,

  getFuel = function(veh)
    local level,type = exports["ti_fuel"]:getFuel(veh)
    return level, type
  end
}
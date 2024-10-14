return {
  addKeys = function(veh, plate)
    return exports['Renewed-Vehiclekeys']:addKey(plate) -- Adds a key to the specified player
  end, 

  removeKeys = function(veh, plate)
    return exports['Renewed-Vehiclekeys']:removeKey(plate) -- Removes a key from the specified player
  end,
}
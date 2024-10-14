return {
  addKeys = function(veh, plate)
    return exports.MrNewbVehicleKeys:GiveKeys(veh)
  end, 

  removeKeys = function(veh, plate)
    return exports.MrNewbVehicleKeys:RemoveKeys(veh)
  end,
}
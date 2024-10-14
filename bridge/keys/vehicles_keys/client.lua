return {
  addKeys = function(veh, plate)
    TriggerServerEvent("vehicles_keys:selfGiveVehicleKeys", plate)
  end, 

  removeKeys = function(veh, plate)
    TriggerServerEvent("vehicles_keys:selfRemoveKeys", plate)
  end,
}
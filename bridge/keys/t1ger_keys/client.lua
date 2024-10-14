return {
  addKeys = function(veh, plate)
    local vehicle_display_name = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
    return exports['t1ger_keys']:GiveTemporaryKeys(plate, vehicle_display_name, 'some_keys') 
  end, 

  removeKeys = function(veh, plate)

  end,
}
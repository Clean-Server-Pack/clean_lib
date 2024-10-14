return {
  addKeys = function(veh, plate)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
    local plate = GetVehicleNumberPlateText(veh)
    exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
  end, 

  removeKeys = function(veh, plate)

  end,
}
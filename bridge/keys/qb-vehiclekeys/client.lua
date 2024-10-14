return {
  addKeys = function(veh, plate)
    TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
  end, 

  removeKeys = function(veh, plate)

  end,
}
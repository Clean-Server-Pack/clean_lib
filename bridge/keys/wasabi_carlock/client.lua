return {
  addKeys = function(veh, plate)
    exports.wasabi_carlock:GiveKey(plate)
  end, 

  removeKeys = function(veh, plate)
    exports.wasabi_carlock:RemoveKey(plate)
  end,
}
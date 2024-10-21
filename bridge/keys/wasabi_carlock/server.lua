return {
  addKeys = function(src, veh, plate)
    exports.wasabi_carlock:GiveKey(src, plate)
  end,  

  removeKeys = function(src, veh, plate)
    exports.wasabi_carlock:RemoveKey(src, plate)
  end,
}
return {
  identifier = function()
    return lib.FW.Functions.GetPlayerData().citizenid
  end,

  getPlayerData = function()
    return lib.FW.Functions.GetPlayerData()
  end,

  getInventory = function()
    return lib.FW.Functions.GetPlayerData().items
  end,
}
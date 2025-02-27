return {
  identifier = function()
    return lib.FW.Functions.GetPlayerData().citizenid
  end,

  name = function()
    local player = lib.FW.Functions.GetPlayerData()
    return player.charinfo.firstname, player.charinfo.lastname
  end,

  getPlayerData = function(_key)
    local playerData = lib.FW.Functions.GetPlayerData()
    return _key and playerData[_key] or playerData
  end,

  getMetadata = function(_key)
    local metadata = lib.FW.Functions.GetPlayerData().metadata
    return _key and metadata[_key] or metadata 
  end,

  getInventory = function()
    return lib.FW.Functions.GetPlayerData().items
  end,

  getMoney = function(_account)
    local playerData = lib.FW.Functions.GetPlayerData()
    return playerData.money[_account] or 0
  end
}
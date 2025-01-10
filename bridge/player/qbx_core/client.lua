return {
  identifier = function()
    return lib.FW.Functions.GetPlayerData().citizenid
  end,

  getPlayerData = function()
    return lib.FW.Functions.GetPlayerData()
  end,

  getMetadata = function(_key)
    local metadata = lib.FW.Functions.GetPlayerData().metadata
    return _key and metadata[_key] or metadata 
  end,

  getInventory = function()
    return lib.FW.Functions.GetPlayerData().items
  end,
}
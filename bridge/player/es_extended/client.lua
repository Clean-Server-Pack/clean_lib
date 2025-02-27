return {
  identifier = function()
    return lib.FW.PlayerData.identifier
  end,

  name = function()
    local name = lib.FW.PlayerData.name 
    local firstName, lastName = name:match("(%a+)%s+(.*)")
    return firstName, lastName
  end,

  getPlayerData = function() -- needs formatting
    return lib.FW.PlayerData
  end,

  getInventory = function()
    return lib.FW.inventory
  end,

  getMetadata = function(_key)
    lib.print.error('es_extended does not support metadata')  
    return {}
  end,
  
  getMoney = function(_account)
    local accounts = lib.FW.PlayerData.accounts  
    for _, account in pairs(accounts) do
      if account.name == _account then
        return account.money
      end
    end
    return 0
  end
}
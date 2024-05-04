lib.player = {
  get = function(src)
    if settings.framework == 'qb-core' then 
      return QBCore.Functions.GetPlayer(src)
    elsif settings.framework == 'esx' then 
      return ESX.GetPlayerFromId(src)
    end
  end,

  identifier = function(src)
    local player = lib.getPlayer(src)
    if settings.framework == 'qb-core' then 
      return player.PlayerData.citizenid
    elseif settings.framework == 'esx' then 
      return player.identifier
    end
  end,
  
  name  = function(src)
    
  end,

  addMoney = function(src, acc, amount, reason)
    local player = lib.getPlayer(src)
    if settings.framework == 'qb-core' then 
      player.Functions.AddMoney(acc, amount, reason)
    elseif settings.framework == 'esx' then 

    end
  end, 

  removeMoney = function(src,acc, amount, reason)
    local player = lib.getPlayer(src)
    if settings.framework == 'qb-core' then 
      player.Functions.RemoveMoney(acc, amount, reason)
    elseif settings.framework == 'esx' then 

    end
  end,

  addItem = function()

  end,

  removeItem = function(src, item ,amount ,md, slot)

  end,

  getInventory = function(src)

  end,

  

}


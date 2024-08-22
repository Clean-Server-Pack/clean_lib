local settings = lib.settings
lib.player = {
  get = function(src)
    assert(type(src) == 'number', 'src must be a number')
    print('Framework is ', settings.framework)
    if settings.framework == 'qb-core' then 

      print(QBCore, server_scripts)
      return QBCore.Functions.GetPlayer(src)
    elseif settings.framework == 'es_extended' then 
      return ESX.GetPlayerFromId(src)
    end
  end,

  identifier = function(src)

    print('Getting Identifier for player', src)
    local ply = lib.player.get(src)
    assert(player, 'Player does not exist')

    if settings.framework == 'qb-core' then 
      return ply.PlayerData.citizenid
    elseif settings.framework == 'es_extended' then 
      return ply.identifier
    end
  end,
  
  name  = function(src)
    local ply = lib.player.get(src)
    if settings.framework == 'qb-core' then 
      return ply.PlayerData.charinfo.firstname, ply.PlayerData.charinfo.lastname
    elseif settings.framework == 'es_extended' then 
      local raw = ply.getName()
      local firstName, lastName = raw:match("(%a+)%s+(.*)")
      return firstName, lastName
    end
  end,

  phone_number = function(src)
    if settings.framework == 'qb-core' then 
      return ply.PlayerData.charinfo.phone
    elseif settings.framework == 'es_extended' then 
      local result = MySQL.Sync.fetchAll("SELECT phone_number FROM users WHERE identifier = @identifier", {['@identifier'] = ply.identifier})
      return result[1] or "No Number"
    end
  end,

  gender       = function(src)
    local ply = lib.player.get(src)
    if settings.framework == 'qb-core' then 
      return ply.PlayerData.charinfo.gender or 'unknown'
    elseif settings.framework == 'es_extended' then
      return 'unknown'
    end 
  end, 

  deleteCharacter = function(src, citizenId)
    if settings.framework == 'qb-core' then 
      return QBCore.Player.DeleteCharacter(src, citizenId)
    elseif settings.framework == 'es_extended' then 

    end
  end, 

  loginCharacter = function(src, citizenId, newData)
    if settings.framework == 'qb-core' then 
      return QBCore.Player.Login(src, citizenId, newData)
    elseif settings.framework == 'es_extended' then 

    end
  end,

  checkOnline = function(identifier)
    assert(type(identifier) == 'string' or type(identifier) == 'number', 'Identifier must be a string or number')
    if type(identifier) == 'number' then 
      return GetPlayerByServerId(identifier) ~= 0
    end
    local plys = GetPlayers()
    for _, ply in ipairs(plys) do 
      local other_ply = lib.player.get(ply)
      if other_ply then 
        if identifier == lib.player.identifier(ply) then 
          return true
        end
      end
    end
    return false
  end,

  jail = function(trg, data)
    if settings.jail_system == 'esx_jail' then 
      TriggerEvent('esx_jail:sendToJail', trg, data.time * 60, true)
    elseif settings.jail__system == 'qb-prison' then 

    end 
  end,

  addMoney = function(src, acc, amount, reason)
    local ply = lib.player.get(src)
    if settings.framework == 'qb-core' then 
      ply.Functions.AddMoney(acc, amount, reason)
    elseif settings.framework == 'es_extended' then 

    end
  end, 

  removeMoney = function(src,acc, amount, reason)
    local ply = lib.player.get(src)
    if settings.framework == 'qb-core' then 
      ply.Functions.RemoveMoney(acc, amount, reason)
    elseif settings.framework == 'es_extended' then 
    
    elseif settings.framework == 'qbox' then 
      ply.Functions.RemoveMoney(acc, amount, reason)
    end
  end,

  addItem = function(src, item, amount, md, slot)
    
  end,

  removeItem = function(src, item ,amount ,md, slot)

  end,

  editItem = function(src, slot, new_data)
    local ply = lib.player.get(src)
    if settings.inventory == "qs-inventory" then
      exports['qs-inventory']:SetItemMetadata(src, slot, new_data)
    elseif settings.inventory == "ox_inventory" then
      exports['ox_inventory']:SetMetadata(src, slot, new_data)
    elseif settings.inventory == "core_inventory" then
      print(' FEATURE NOT SUPPORTED YET')
    else
      --## FALL BACK FOR MOST INVENTORIES
      -- OLD QS
      -- QB-INVENTORY
      -- LJ-INVENTORY
      -- ESX-INVENTORY
      if settings.framework == "es_extended" then
        ply.addInventoryItem(i,a, md or nil)
      elseif settings.framework == "qb-core" then
        local item = ply.Functions.GetItemBySlot(slot)
        if item then 
          if ply.Functions.RemoveItem(item.name,item.amount,slot) then 
            ply.Functions.AddItem(item.name,item.amount, slot, new_data)
          end
        end
      end
    end
  end,

  getInventory = function(src)
    local ply = lib.player.get(src)
    assert(ply, 'Player does not exist')
    local sanitized = {}
    local raw_inv   = false 
    if settings.framework == 'es_extended' then
      raw_inv = ply.getInventory()
    elseif settings.framework == 'qb-core' then 
      raw_inv = ply.PlayerData.items
    end

    assert(raw_inv and type(raw_inv) == 'table', 'Inventory is not a table or does not exist?')

    for k,v in ipairs(raw_inv) do
      if (v.amount and v.amount >= 1) or (v.count and v.count >= 1) then
      table.insert(sanitized, {
          name  = v.name,
          label = v.label,
          count = (v.amount or v.count),
          info  = (v.info or v.metadata or false),
          slot  = (v.slot or nil),
        })
      end
    end
    return sanitized
  end,
}

return lib.player
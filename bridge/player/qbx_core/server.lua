

return {
  get = function(src)
    return exports['qbx_core']:GetPlayer(src)
  end,

  identifier = function(src)
    local ply = lib.player.get(src)
    assert(ply, 'Player does not exist')
    return ply.PlayerData.citizenid
  end, 

  name = function(src)
    local ply = lib.player.get(src)
    assert(ply, 'Player does not exist')
    return ply.PlayerData.charinfo.firstname, ply.PlayerData.charinfo.lastname
  end,

  phone_number = function(src)
    local ply = lib.player.get(src)
    assert(ply, 'Player does not exist')
    return ply.PlayerData.charinfo.phone
  end, 

  gender = function(src)
    local ply = lib.player.get(src)
    assert(ply, 'Player does not exist')
    return ply.PlayerData.charinfo.gender or 'unknown'
  end, 

  deleteCharacter = function(src, citizenId)
    return exports.qbx_core:DeleteCharacter(citizenId)
  end,

  loginCharacter = function(src, citizenId, newData)
    return exports.qbx_core:Login(src, citizenId, newData)
  end,

  logoutCharacter = function(src, citizenId)
    return exports.qbx_core:Logout(src)
  end,

  jail = function()

  end, 

  addMoney = function(src, acc, count, reason)

  end, 

  removeMoney = function(src, acc, count, reason)

  end,

  addItem = function(src, item, count, slot, md)

  end,

  removeItem = function(src, item, count, slot, md)

  end,

  getInventory = function(src)

  end,
}
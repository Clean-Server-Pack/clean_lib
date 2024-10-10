

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

  setJob = function(src, name, rank)
    local ply = lib.player.get(src)
    if not ply then return end
    ply.Functions.SetJob(name, rank)
  end,
  
  setDuty = function(src, duty)
    local ply = lib.player.get(src)
    if not ply then return end
    ply.Functions.SetJobDuty(duty)
  end,

  setPlayerData = function(src, _key, data)
    local ply = lib.player.get(src)
    if not ply then return end
    ply.Functions.SetPlayerData(_key, data)
  end,

  jail = function()

  end, 

  addMoney = function(src, acc, count, reason)
    local ply = lib.player.get(src)
    if not ply then return end
    return ply.Functions.AddMoney(acc, count, reason)
  end, 

  removeMoney = function(src, acc, count, reason)
    local ply = lib.player.get(src)
    if not ply then return end
    return ply.Functions.RemoveMoney(acc, count, reason)
  end,
}
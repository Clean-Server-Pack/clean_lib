return {
  get = function(src)
    return lib.FW.Functions.GetPlayer(src)
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
    return lib.FW.DeleteCharacter(src, citizenId)
  end,

  loginCharacter = function(src, citizenId, newData)
    return lib.FW.Login(src, citizenId, newData)
  end,

  logoutCharacter = function(src, citizenId)
    return lib.FW.Logout(src, citizenId)
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

  jail = function()

  end, 

  addMoney = function(src, acc, count, reason)

  end, 

  removeMoney = function(src, acc, count, reason)

  end,
}
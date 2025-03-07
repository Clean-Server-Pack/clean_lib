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

  phoneNumber = function(src)
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

  getJob = function(src)
    local ply = lib.player.get(src)
    if not ply then return end
    local rawJob = ply.PlayerData.job
    local ret = {
      name       = rawJob.name,
      type       = rawJob.type,
      label      = rawJob.label,
      grade      = rawJob.grade.level,
      isBoss     = rawJob.grade.isboss,
      bankAuth   = rawJob.bankAuth,
      gradeLabel = rawJob.grade.name,
      duty       = rawJob.onduty
    }
    return ret
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

  getMoney = function(src, acc)
    local ply = lib.player.get(src)
    if not ply then return end
    return ply.Functions.GetMoney(acc)
  end,

  addMoney = function(src, acc, count, reason)
    local ply = lib.player.get(src)
    if not ply then return end
    return ply.Functions.AddMoney(acc, count, reason)
  end, 

  removeMoney = function(src, acc, count, reason, force)
    local ply = lib.player.get(src)
    if not ply then return end
    if not force then
      local has = ply.Functions.GetMoney(acc)
      if has < count then return false, 'not_enough' end
    end
    return ply.Functions.RemoveMoney(acc, count, reason)
  end,

  setMoney = function(src, acc, count)
    local ply = lib.player.get(src)
    if not ply then return end
    return ply.Functions.SetMoney(acc, count)
  end
}
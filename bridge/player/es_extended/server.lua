

return {
  get = function(src)
    return lib.FW.GetPlayerFromId(src)
  end,

  identifier = function(src)
    local ply = lib.player.get(src)
    assert(ply, 'Player does not exist')
    return ply.PlayerData.identifier
  end, 

  name = function(src)
    local ply = lib.player.get(src)
    assert(ply, 'Player does not exist')
    local raw = ply.getName()
    local firstName, lastName = raw:match("(%a+)%s+(.*)")
    return firstName, lastName
  end,

  phone_number = function(src)
    local ply = lib.player.get(src)
    assert(ply, 'Player does not exist')
    local result = MySQL.Sync.fetchAll("SELECT phone_number FROM users WHERE identifier = @identifier", {['@identifier'] = ply.identifier})
    return result[1] or "No Number"
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
    assert(ply, 'Player does not exist')
    ply.setJob(name, rank)
  end,
  
  setDuty = function(src, duty)
    local ply = lib.player.get(src)
    assert(ply, 'Player does not exist')
    ply.setJobDuty(duty)
  end,

  setPlayerData = function(src, _key, data)
    local ply = lib.player.get(src)
    assert(ply, 'Player does not exist')
    ply.Functions.SetPlayerData(_key, data)
  end,

  jail = function()

  end, 

  addMoney = function(src, acc, count, reason)
    local ply = lib.player.get(src)
    assert(ply, 'Player does not exist')
    return ply.addAccountMoney(acc,count)
  end, 

  removeMoney = function(src, acc, count, reason)
    local ply = lib.player.get(src)
    assert(ply, 'Player does not exist')
    local accounts = ply.getAccounts() or {}
    if not accounts[acc] then return false, 'no_account' end
    if accounts[acc].money < count then return false, 'insufficient_funds' end
    return ply.removeAccountMoney(acc,count)
  end,
}
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
  end,

  getJob = function()
    local playerData = lib.FW.PlayerData
    local rawJob = playerData.job
    local jobInfo = lib.FW.Jobs[rawJob.name] or {}
    local gradeInfo = jobInfo.grades and jobInfo.grades[tostring(rawJob.grade)] or {}
    local ret = {
      name       = rawJob.name,
      type       = rawJob.type,
      label      = rawJob.label,
      grade      = rawJob.grade,
      gradeLabel = rawJob.grade_label,
      bankAuth   = rawJob.bankAuth,
      isBoss     = rawJob.isboss,
      duty       = false
    }
    return ret
  end,
}
local settings = lib.settings

if settings.framework == 'qb-core' then
  RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local PlayerData =  lib.FW.Functions.GetPlayerData()
    cache:set('citizenId', PlayerData.citizenid)
    cache:set('charName', PlayerData.charinfo.firstname..' '..PlayerData.charinfo.lastname)
    cache:set('job', {
      name = PlayerData.job.name,
      type = PlayerData.job.type,
      label = PlayerData.job.label,
      grade = PlayerData.job.grade.level,
      isBoss = PlayerData.job.isboss,
      bankAuth = PlayerData.job.bankAuth,
      gradeLabel = PlayerData.job.grade.name,
      duty = PlayerData.job.onduty
    })

    cache:set('playerLoaded', true)
    cache:set('metadata', PlayerData.metadata)
  end)

  AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then 
      local playerData = lib.FW.Functions.GetPlayerData()
      if not playerData then return end
      if not playerData.job?.name then return end
      TriggerEvent('QBCore:Client:OnPlayerLoaded')
    end
  end)

  RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    cache:set('playerLoaded', false)
    cache:set('job', {
      name = 'logged_off',
      grade = 2,
      onduty = false
    })
  end)

  RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    cache:set('job', {
      name = job.name,
      type = job.type,
      label = job.label,
      grade = job.grade.level,
      isBoss = job.isboss,
      bankAuth = job.bankAuth,
      gradeLabel = job.grade.name,
      duty = job.onduty
    })
  end)

  RegisterNetEvent('QBCore:Client:SetDuty', function(duty) 
    local originalCache = json.decode(json.encode(cache.job)) 
    originalCache.onduty = duty
    cache:set('job', originalCache)
  end)

  RegisterNetEvent('QBCore:Client:UpdatePlayerData', function(data)
    cache:set('playerData', data)
  end)

elseif settings.framework == 'qbx_core' then 
  AddStateBagChangeHandler('isLoggedIn', ('player:%s'):format(cache.serverId), function(_, _, value)
    if value then   
      print('player loaded')
      local PlayerData =  lib.FW.Functions.GetPlayerData()
      if not PlayerData or not PlayerData.job then return end
      cache:set('citizenId', PlayerData.citizenid)
      cache:set('charName', PlayerData.charinfo.firstname..' '..PlayerData.charinfo.lastname)
      cache:set('job', {
        name = PlayerData.job.name,
        type = PlayerData.job.type,
        label = PlayerData.job.label,
        grade = PlayerData.job.grade.level,
        isBoss = PlayerData.job.isboss,
        bankAuth = PlayerData.job.bankAuth,
        gradeLabel = PlayerData.job.grade.name,
        duty = PlayerData.job.onduty
      })
      cache:set('playerLoaded', true)
      cache:set('metadata', PlayerData.metadata)
    else
      cache:set('playerLoaded', false)
      cache:set('job', {
        name = 'logged_off',
        grade = 2,
        onduty = false
      })
    end
  end)

  RegisterNetEvent('QBCore:Client:SetDuty', function(duty) 
    local originalCache = json.decode(json.encode(cache.job)) 
    originalCache.onduty = duty
    cache:set('job', originalCache)
  end)

  RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang) 
    cache:set('gang', gang)
  end)

  RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job) 
    cache:set('job', {
      name = job.name,
      type = job.type,
      label = job.label,
      grade = job.grade.level,
      isBoss = job.isboss,
      bankAuth = job.bankAuth,
      gradeLabel = job.grade.name,
      duty = job.onduty
    })
  end)

  RegisterNetEvent('qbx_core:client:onSetMetaData', function(meta, oldVal, val)
    local old_data = cache.metadata or {}
    old_data[meta] = val
    cache:set('metadata', old_data)
  end)


  RegisterNetEvent('QBCore:Player:SetPlayerData', function(newData)
    cache:set('playerData', newData)
  end)

elseif settings.framework == 'es_extended' then
  CreateThread(function()
    while not lib.FW do Wait(500); end 
    while not lib.FW.IsPlayerLoaded() do Wait(500); end
    local PlayerData =  lib.FW.GetPlayerData()
    cache:set('citizenId', PlayerData.identifier)
    cache:set('job', {
      name = PlayerData.job.name,
      type = PlayerData.job.type,
      label = PlayerData.job.label,
      grade = PlayerData.job.grade,
      isBoss = PlayerData.job.isboss,
      bankAuth = PlayerData.job.bankAuth,
      gradeLabel = PlayerData.job.grade_label,
      duty = PlayerData.job.onduty
    })
    cache:set('playerLoaded', true)
  end)

  AddEventHandler('esx:playerLoaded', function(xPlayer)
    cache:set('citizenId', xPlayer.identifier)
    cache:set('job', {
      name = xPlayer.job.name,
      type = xPlayer.job.type,
      label = xPlayer.job.label,
      grade = xPlayer.job.grade,
      isBoss = xPlayer.job.isboss,
      bankAuth = xPlayer.job.bankAuth,
      gradeLabel = xPlayer.job.grade_label,
      duty = xPlayer.job.onduty
    })
    cache:set('playerLoaded', true)
  end)

  AddEventHandler('esx:setJob', function(job)
    cache:set('job', {
      name = job.name,
      type = job.type,
      label = job.label,
      grade = job.grade,
      isBoss = job.isboss,
      bankAuth = job.bankAuth,
      gradeLabel = job.grade_label,
      duty = job.onduty
    })
  end)
end


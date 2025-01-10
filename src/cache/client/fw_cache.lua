local settings = lib.settings

if settings.framework == 'qb-core' then
  RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local PlayerData =  lib.FW.Functions.GetPlayerData()
    cache:set('citizenId', PlayerData.citizenid)
    cache:set('job', {
      name = PlayerData.job.name,
      grade = PlayerData.job.grade.level,
      onduty = PlayerData.job.onduty
    })
    cache:set('playerLoaded', true)
  end)

  RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    cache:set('playerLoaded', false)
  end)

  RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    cache:set('job', {
      name = job.name,
      grade = job.grade.level,
      onduty = job.onduty,
    })
  end)

  RegisterNetEvent('QBCore:Client:SetDuty', function(duty) 
    cache:set('job', {
      name = cache.job.name,
      grade = cache.job.grade,
      onduty = duty
    })
  end)

  RegisterNetEvent('QBCore:Client:UpdatePlayerData', function(data)
    cache:set('playerData', data)
  end)

elseif settings.framework == 'qbx_core' then 
  AddStateBagChangeHandler('isLoggedIn', ('player:%s'):format(cache.serverId), function(_, _, value)
    if value then   
      local PlayerData =  lib.FW.Functions.GetPlayerData()
      if not PlayerData or not PlayerData.job then return end
      cache:set('citizenId', PlayerData.citizenid)
      cache:set('job', {
        name = PlayerData.job.name,
        grade = PlayerData.job.grade.level,
        onduty = PlayerData.job.onduty
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
    cache:set('job', {
      name = cache.job.name,
      grade = cache.job.grade,
      onduty = duty
    })
  end)

  RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang) 
    cache:set('gang', {
      name  = gang.name,
      grade = gang.rank,
    })
  end)

  RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job) 
    cache:set('job', {
      name = job.name,
      grade = job.grade.level,
      onduty = job.onduty
    })
  end)

  RegisterNetEvent('qbx_core:client:onSetMetaData', function(meta, oldVal, val)
    local old_data = cache.metadata or {}
    old_data[meta] = val
    lib.print.info(('Updated metadata key: %s'):format(meta))
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
      grade = PlayerData.job.grade,
      onduty = PlayerData.job.onduty
    })
    cache:set('playerLoaded', true)
  end)

  AddEventHandler('esx:playerLoaded', function(xPlayer)
    cache:set('citizenId', xPlayer.identifier)
    cache:set('job', {
      name = xPlayer.job.name,
      grade = xPlayer.job.grade,
      onduty = xPlayer.job.onduty
    })
    cache:set('playerLoaded', true)
  end)

  AddEventHandler('esx:setJob', function(job)
    cache:set('job', {
      name = job.name,
      grade = job.grade,
      onduty = job.onduty
    })
  end)
end
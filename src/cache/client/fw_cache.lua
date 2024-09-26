local settings = lib.settings

if settings.framework == 'qb-core' then
  RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local PlayerData =  lib.FW.Functions.GetPlayerData()
    cache:set('playerLoaded', PlayerData)
    cache:set('citizenId', PlayerData.citizenid)
    cache:set('job', {
      name = PlayerData.job.name,
      grade = PlayerData.job.grade.level,
      onduty = PlayerData.job.onduty
    })
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

  RegisterNetEvent('QBCore:Client:UpdatePlayerData', function(data)
    cache:set('playerData', data)
  end)

elseif settings.framework == 'qbx_core' then 
  RegisterNetEvent('isLoggedIn', ('player:%s'):format(cache.serverId), function(_, _, value)
    if value then   
      local PlayerData =  lib.FW.Functions.GetPlayerData()
      if not PlayerData or not PlayerData.job then return end
      cache:set('playerLoaded', true)
      cache:set('citizenId', PlayerData.citizenid)
      cache:set('job', {
        name = PlayerData.job.name,
        grade = PlayerData.job.grade.level,
        onduty = PlayerData.job.onduty
      })
    else
      cache:set('playerLoaded', false)
      cache:set('job', {
        name = 'logged_off',
        grade = 2,
        onduty = false
      })
    end
  end)

  RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    local PlayerData = lib.FW.Functions.GetPlayerData()
    cache:set('job', {
      name = PlayerData.job.name,
      grade = PlayerData.job.grade.level,
      onduty = PlayerData.job.onduty
    })
  end)

  RegisterNetEvent('qbx_core:client:onGroupUpdate', function(groupName, groupGrade)
    local PlayerData = lib.FW.Functions.GetPlayerData()
    if groupName == 'job' then
      cache:set('job', {
          name = PlayerData.job.name,
          grade = PlayerData.job.grade.level,
          onduty = PlayerData.job.onduty
      })
    end
  end)
elseif settings.framework == 'es_extended' then
  AddEventHandler('esx:setJob', function(job)
    cache:set('job', {
      name = job.name,
      grade = job.grade,
      onduty = job.onduty
    })
  end)
end
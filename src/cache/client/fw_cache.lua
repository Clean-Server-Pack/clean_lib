local settings = lib.settings
local stored_events = {}
local job = {}

if settings.framework == 'qb-core' then
  AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local PlayerData =  lib.FW.Functions.GetPlayerData()
    cache:set('playerLoaded', PlayerData)
    cache:set('playerData', PlayerData)
    cache:set('citizenId', PlayerData.citizenid)
  end)

  AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    cache:set('playerLoaded', false)
  end)

  AddEventHandler('QBCore:Client:JobUpdate', function(job)
    cache:set('job', job)
  end)

  AddEventHandler('QBCore:Client:UpdatePlayerData', function(data)
    cache:set('playerData', data)
  end)

elseif settings.framework == 'qbx_core' then 
  AddStateBagChangeHandler('isLoggedIn', ('player:%s'):format(cache.serverId), function(_, _, value)
      print('ISLOADED', value)
    if value then   
      local PlayerData =  lib.FW.Functions.GetPlayerData()
      if not PlayerData or not PlayerData.job then return end
      cache:set('playerLoaded', true)
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

  AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    cache:set('job', {
      name = job.name,
      grade = job.grade.level, 
      onduty = job.onduty
    })
  end)

  AddEventHandler('qbx_core:client:onGroupUpdate', function(groupName, groupGrade)
  
  end)
elseif settings.framework == 'es_extended' then

end
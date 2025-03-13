if lib.settings.framework ~= 'qbx_core' then return end


local playerLoggedIn = function()
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
end 

AddStateBagChangeHandler('isLoggedIn', ('player:%s'):format(cache.serverId), function(_, _, value)
  if value then   
    playerLoggedIn()
  else
    cache:set('playerLoaded', false)
    cache:set('job', {
      name = 'logged_off',
      grade = 2,
      onduty = false
    })
  end
end)

AddEventHandler('onResourceStart', function(resourceName)
  if resourceName == GetCurrentResourceName() then 
    if not LocalPlayer.state.isLoggedIn then return end
    playerLoggedIn()
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
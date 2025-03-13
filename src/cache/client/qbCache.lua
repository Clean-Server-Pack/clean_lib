
if lib.settings.framework ~= 'qb-core' then return end

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
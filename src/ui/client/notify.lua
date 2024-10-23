local types = {
  ['error'] = {
    icon = 'fas fa-exclamation-circle',
    iconColor = 'rgba(155, 0, 0)',
  },
  ['success'] = {
    icon = 'fas fa-check-circle',
    iconColor = 'rgba(0, 155, 0)',
  },
  ['inform'] = {
    icon = 'fas fa-info-circle',
  },
  ['warning'] = {
    icon = 'fas fa-exclamation-triangle',
    iconColor = 'rgba(155, 155, 0)',
  },
}

local notification = nil
lib.notify = function(data)

  if lib.settings.notify == 'ox_lib' then 
    return TriggerEvent('ox_lib:notify', data)
  end 

  while notification do Wait(0) end
  notification = true
  SetTimeout(100, function() notification = nil end)
  local settings = lib.settings
  if not settings.notify or settings.notify == 'clean_lib' then
    local sound = settings.notifyAudio and data.sound

    data.title = data.title or data.type and types[data.type].title or 'Notification'
    data.position = data.position or settings.notifyPosition or 'top-right'
    data.icon = data.icon or data.type and types[data.type] and types[data.type].icon or types['inform'].icon
    data.iconColor = data.iconColor or types[data.type] and types[data.type].iconColor

    SendNuiMessage(json.encode({
      action = 'ADD_NOTIFICATION',
      data   = data
    }))

    if not sound then return end
    if sound.bank then lib.request.audioBank(sound.bank) end
    local soundId = GetSoundId()
    PlaySoundFrontend(soundId, sound.name, sound.set, true)
    ReleaseSoundId(soundId)
    if sound.bank then ReleaseNamedScriptAudioBank(sound.bank) end
  end
end

RegisterNetEvent('clean_lib:notify', lib.notify)
RegisterNetEvent('clean_lib:defaultNotify', lib.defaultNotify)

lib.defaultNotify = function(data)
  if lib.settings.notify == 'ox_lib' then 
    return TriggerEvent('clean_lib:defaultNotify', data)
  end

  data.type = data.status
  if data.type == 'inform' then data.type = 'info' end
  return lib.notify(data)
end


-- Command to test all types of notifications
RegisterCommand('notify', function()
  lib.notify({
    type = 'error',
    description = 'This is an error notification',
    sound = { name = 'ERROR', set = 'HUD_LIQUOR_STORE_SOUNDSET' }
  })

  lib.notify({
    type = 'success',
    description = 'This is a success notification',
    sound = { name = 'NAV', set = 'HUD_LIQUOR_STORE_SOUNDSET' }
  })

  lib.notify({
    type = 'inform',
    description = 'This is an inform notification',
    sound = { name = 'NAV', set = 'HUD_LIQUOR_STORE_SOUNDSET' }
  })

  lib.notify({
    type = 'warning',
    description = 'This is a warning notification',
    sound = { name = 'NAV', set = 'HUD_LIQUOR_STORE_SOUNDSET' }
  })
end, false)



RegisterCommand('test_menus', function()
  local options = {
    {
      title = 'Option 1',
      icon = 'fas fa-rocket',
      onSelect = function()
        print('Option 1 selected')
      end
    },
    {
      title = 'Option 2',
      icon = 'fas fa-rocket',
      menu = 'back_menu',
    }
  
  
  }

  lib.registerContext({
    id = 'whippet_shop',
    title = 'Menu 1',
    menu = 'back_menu',
    icon = 'fas fa-rocket',
    options = options,
  })

  lib.registerContext({
    id = 'back_menu',
    title = 'Menu Back',
    menu = 'back_menu',
    icon = 'fas fa-rocket',
    options = options,
  })

  Wait(0)
  lib.openContext('whippet_shop')
end)
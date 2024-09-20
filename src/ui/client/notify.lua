local types = {
  ['error'] = {
    icon = 'fas fa-exclamation-circle',
    iconColor = 'rgba(255, 0, 0, 0.8)',
  },
  ['success'] = {
    icon = 'fas fa-check-circle',
    iconColor = 'rgba(0, 255, 0, 0.8)',
  },
  ['inform'] = {
    icon = 'fas fa-info-circle',
    iconColor = 'rgba(0, 0, 255, 0.8)',
  },
  ['warning'] = {
    icon = 'fas fa-exclamation-triangle',
    iconColor = 'rgba(255, 255, 0, 0.8)',
  },
}


lib.notify = function(data)
  local settings = lib.settings
  if not settings.notify or settings.notify == 'clean_lib' then
    local sound = settings.notify_audio and data.sound
    data.position = settings.notify_position or 'top-right'
    data.icon = data.icon or types[data.type] and types[data.type].icon or types['inform'].icon
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

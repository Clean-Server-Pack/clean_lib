return {
  syncTime = function(state)
    TriggerEvent('cd_easytime:PauseSync', state)
    return true 
  end

}
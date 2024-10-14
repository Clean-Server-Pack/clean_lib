return {

  syncTime = function(state)
    if state then TriggerEvent('qb-weathersync:client:EnableSync') else TriggerEvent('qb-weathersync:client:DisableSync') end
    return true 
  end,
}
return {
  syncTime = function(state)
    TriggerEvent('av_weather:freeze',state)
    exports['av_weather']:setRain(false)
    return true
  end
}
local time = lib.loadBridge('time', settings.time, 'client')

lib.game = {
  syncTime = function(state)
    if not time.syncTime then return lib.print.error(('No bridge found for syncing time for %s'):format(settings.time)) end
    return time.syncTime(state)  
  end,
}
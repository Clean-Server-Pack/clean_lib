local time = lib.loadBridge('time', settings.time, 'client')

lib.game = {
  syncTime = function(state)
    return time.syncTime(state) or lib.print.error(('No bridge found for syncing time for %s'):format(settings.time))    
  end,
}
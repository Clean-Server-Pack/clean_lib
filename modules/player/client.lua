local settings      = lib.settings
local bridge        = lib.loadBridge('player', settings.framework, 'client')

lib.player = {
  ---@return string
  identifier = bridge.identifier,

}

return lib.player

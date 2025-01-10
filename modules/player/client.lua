local settings      = lib.settings
local bridge        = lib.loadBridge('player', settings.framework, 'client')

lib.player = {
  ---@return string
  identifier = bridge.identifier,
  getInventory = bridge.getInventory,
  getPlayerData = bridge.getPlayerData,
  getMetadata   = bridge.getMetadata,
}

return lib.player

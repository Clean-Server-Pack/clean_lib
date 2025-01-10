local settings      = lib.settings
local bridge        = lib.loadBridge('player', settings.framework, 'server')
local prison        = lib.loadBridge('prison', settings.prison, 'server')

return  {
  ---@param src number | string 
  ---@return table
  get = bridge.get,

  ---@param src number
  ---@return string
  identifier      = bridge.identifier,

  ---@param src number
  ---@return string, string
  name            = bridge.name,
  
  ---@param src number
  ---@return string
  phone_number    = bridge.phone_number,

  ---@param src number
  ---@return string
  gender          = bridge.gender,

  ---@param src number
  ---@param citizenId string
  ---@return boolean
  deleteCharacter = bridge.deleteCharacter,

  ---@param src number
  ---@param citizenId string
  ---@param newData table
  ---@return boolean
  loginCharacter  = bridge.loginCharacter,

  ---@param src number
  ---@param citizenId string
  ---@return boolean
  logoutCharacter = bridge.logoutCharacter,

  ---@param src number
  ---@param time number
  ---@param reason string
  ---@return boolean
  jail = prison.jail or bridge.jail,  

  ---@param src number
  ---@param acc string
  ---@param count number
  ---@param reason string
  ---@return boolean
  addMoney = bridge.addMoney,

  ---@param src number
  ---@param job string
  ---@param rank string | number
  setJob   = bridge.setJob,

  ---@param src number
  ---@param duty boolean
  setDuty  = bridge.setDuty,

  ---@param src number
  ---@param acc string
  ---@param count number
  ---@param reason string
  ---@return boolean
  removeMoney = bridge.removeMoney,
  
  ---@param src number
  ---@param _key string
  ---@param data table
  setPlayerData = bridge.setPlayerData,

  ---@param src number
  ---@param _key string
  ---@return table
  getPlayerData = bridge.getPlayerData,

  ---@param src number
  ---@param _key string
  ---@param data table
  setMetadata = bridge.setMetadata,

  ---@param src number
  ---@param _key string
  ---@return table
  getMetadata = bridge.getMetadata,

  ---@param identifier string|number
  ---@return boolean
  checkOnline = function(identifier)
    assert(type(identifier) == 'string' or type(identifier) == 'number', 'Identifier must be a string or number')
    if type(identifier) == 'number' then 
      return GetPlayerByServerId(identifier) ~= 0
    end
    local plys = GetPlayers()
    for _, ply in ipairs(plys) do 
      local other_ply = lib.player.get(tonumber(ply))
      if other_ply then 
        if identifier == lib.player.identifier(tonumber(ply)) then
          return ply
        end
      end
    end
    return false
  end,


}

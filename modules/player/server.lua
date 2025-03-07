local settings      = lib.settings
local bridge        = lib.loadBridge('player', settings.framework, 'server')
local prison        = lib.loadBridge('prison', settings.prison, 'server')

return  {
  ---@function lib.player.get
  ---@description # Get the player object
  ---@param src number | string 
  ---@return table
  get = bridge.get,

  ---@function lib.player.identifier
  ---@description # Get the identifier of a player
  ---@param src number
  ---@return string
  identifier      = bridge.identifier,

  ---@function lib.player.name
  ---@description # Get the name of a player
  ---@param src number
  ---@return string, string
  name            = bridge.name,
  
  ---@function lib.player.phoneNumber
  ---@description # Get the phone number of a player.
  ---@param src number
  ---@return string
  phoneNumber    = bridge.phoneNumber,

  ---@function lib.player.gender 
  ---@description # Gets the gender of a player
  ---@param src number
  ---@return string
  gender          = bridge.gender,

  ---@function lib.player.deleteCharacter
  ---@description # Deletes a character
  ---@param src number
  ---@param citizenId string
  ---@return boolean
  deleteCharacter = bridge.deleteCharacter,

  ---@function lib.player.loginCharacter
  ---@description # Logs in a character
  ---@param src number
  ---@param citizenId string
  ---@param newData table
  ---@return boolean
  loginCharacter  = bridge.loginCharacter,

  ---@function lib.player.logoutCharacter
  ---@description # Logs out a character
  ---@param src number
  ---@param citizenId string
  ---@return boolean
  logoutCharacter = bridge.logoutCharacter,

  ---@function lib.player.jail
  ---@description # Jails a player
  ---@param src number
  ---@param time number
  ---@param reason string
  ---@return boolean
  jail = prison.jail or bridge.jail,  

  ---@function lib.player.setJob
  ---@description # Sets the job of a player
  ---@param src number
  ---@param job string
  ---@param rank string | number
  setJob   = bridge.setJob,

  ---@function lib.player.getJob 
  ---@description # Gets the job of a player
  ---@param src number
  ---@return {name: string, label: string, grade: number, gradeLabel: string, duty: boolean}
  getJob   = bridge.getJob,

  ---@function lib.player.setDuty 
  ---@description # Sets the duty of a player
  ---@param src number
  ---@param duty boolean
  setDuty  = bridge.setDuty,

  ---@function lib.player.addMoney
  ---@description # Adds money to a player
  ---@param src number
  ---@param acc string
  ---@param count number
  ---@param reason string
  ---@return boolean
  addMoney = bridge.addMoney,

  ---@function lib.player.removeMoney
  ---@description # Removes money from a player
  ---@param src number
  ---@param acc string
  ---@param count number
  ---@param reason string
  ---@return boolean
  removeMoney = bridge.removeMoney,

  ---@function lib.player.setMoney 
  ---@description # Sets the money of a player
  ---@param src number
  ---@param acc string
  ---@param count number
  ---@return boolean
  setMoney = bridge.setMoney,

  ---@function lib.player.getMoney
  ---@description # Gets the money of a player
  ---@param src number
  ---@param acc string
  ---@return number
  getMoney = bridge.getMoney,
  
  ---@function lib.player.setPlayerData
  ---@description # Sets the data of a player
  ---@param src number
  ---@param _key string
  ---@param data table
  setPlayerData = bridge.setPlayerData,

  ---@function lib.player.getPlayerData
  ---@description # Gets the data of a player
  ---@param src number
  ---@param _key string
  ---@return table
  getPlayerData = bridge.getPlayerData,

  ---@function lib.player.setMetadata
  ---@description # Sets the metadata of a player
  ---@param src number
  ---@param _key string
  ---@param data table
  setMetadata = bridge.setMetadata,

  ---@function lib.player.getMetadata
  ---@description # Gets the metadata of a player
  ---@param src number
  ---@param _key string
  ---@return table
  getMetadata = bridge.getMetadata,

  ---@function lib.player.checkOnline 
  ---@description # Checks if a player is online either by their character ID or server ID
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

if lib.settings.framework ~= 'es_extended' then return end
local playerMetadatas = {}
local sqlReady = false
-- So for some dumb reason the es_extended framework doesn't support metadata, so we have to do some extra work to get it 
local ensureTable = function()
  local success, result = pcall(MySQL.scalar.await, 'SELECT 1 FROM player_metadata LIMIT 1')
  if not success then
    MySQL.query([[CREATE TABLE `player_metadata` (
      `id` longtext DEFAULT NULL,
      `data` longtext DEFAULT NULL,
      `lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
      UNIQUE KEY `id` (`id`)
    )]])
  end
  sqlReady = true
  return true
end

CreateThread(ensureTable)

lib.loadPlayerMetadata = function(src)
  src = type(src) == 'number' and lib.player.identifier(src) or src
  -- Load metadata from database
  local player = MySQL.single.await('SELECT * FROM player_metadata WHERE id = ?', {src})
  playerMetadatas[src] = player and json.decode(player.data) or {}
  return playerMetadatas[src]
end

lib.savePlayerMetadata = function(src)
  src = type(src) == 'number' and lib.player.identifier(src) or src
  playerMetadatas[src] = playerMetadatas[src] or {}
  local encoded = json.encode(playerMetadatas[src])
  local success = MySQL.prepare('INSERT INTO player_metadata (id, data) VALUES (?, ?) ON DUPLICATE KEY UPDATE data = VALUES(data)',  
    {src, encoded}
  )
  -- Save metadata to database
  return success
end


---@function lib.getPlayerMetadata
---@param src number
---@param _key? string
lib.getPlayerMetadata = function(src, _key)
  src = type(src) == 'number' and lib.player.identifier(src) or src
  playerMetadatas[src] = playerMetadatas[src] or {}
  if not _key then return playerMetadatas[src] end
  return playerMetadatas[src][_key]
end

---@function lib.setPlayerMetadata
---@param src number
---@param _key string
lib.setPlayerMetadata = function(src, _key, value)
  src = type(src) == 'number' and lib.player.identifier(src) or src
  playerMetadatas[src] = playerMetadatas[src] or {}
  playerMetadatas[src][_key] = value
  lib.savePlayerMetadata(src)
  TriggerClientEvent('clean_lib:setPlayerMetadata', src, _key, value)
end

lib.callback.register('clean_lib:getPlayerMetadata', function(src)
  return lib.loadPlayerMetadata(src)
end)


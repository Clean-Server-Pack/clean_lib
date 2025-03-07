if lib.settings.framework ~= 'es_extended' then return end
local metadata = {}

CreateThread(function()
  while not lib.FW do Wait(500); end 
  while not lib.FW.IsPlayerLoaded() do Wait(500); end
  metadata = lib.callback.await('clean_lib:getPlayerMetadata')
end)

lib.getPlayerMetadata = function(_key)
  return _key and metadata[_key] or metadata
end

RegisterNetEvent('clean_lib:setPlayerMetadata', function(_key, value)
  metadata[_key] = value
end)
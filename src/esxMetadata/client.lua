if lib.settings.framework ~= 'es_extended' then return end
local metadata = {}

lib.onCache('playerLoaded', function(loaded)
  if not loaded then return end
  metadata = lib.callback.await('clean_lib:getPlayerMetadata')
end)

lib.getPlayerMetadata = function(_key)
  return _key and metadata[_key] or metadata
end

RegisterNetEvent('clean_lib:setPlayerMetadata', function(_key, value)
  metadata[_key] = value
end)
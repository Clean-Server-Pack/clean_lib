local defaultTimeout = 20000

lib.request = {
  entity = function(entity, timeout)
    assert(entity, 'an entity is required')
    assert(type(entity) == 'number' or type(entity) == 'table', 'entity must be a number or table')
    if not timeout then timeout = defaultTimeout end
    if type(entity) == 'table' then
      for i, v in ipairs(entity) do
        if not lib.request.entity(v, timeout) then
          return false
        end
      end
      return true
    end

    local start_time = GetGameTimer()
    while not DoesEntityExist(entity) do
      if GetGameTimer() - start_time > timeout then
        return false
      end
      Wait(0)
    end
    return true
  end,

  model = function(model, timeout)
    assert(model, 'a model is required')
    assert(type(model) == 'string' or type(model) == 'number' or type(model) == 'table', 'model must be a string or table')
    if not timeout then timeout = defaultTimeout end
    if type(model) == 'table' then
      for i, v in ipairs(model) do
        if not lib.request.model(v, timeout) then
          return false
        end
      end
      return true
    end

    local model = joaat(model)
    local start_time = GetGameTimer()
    while not HasModelLoaded(model) do
      RequestModel(model)
      if GetGameTimer() - start_time > timeout then
        return false
      end
      Wait(0)
    end
    return true
  end,

  ptfxAsset = function(asset, timeout)
    assert(asset, 'a ptfx asset is required')
    assert(type(asset) == 'string' or type(asset) == 'table', 'asset must be a string or table')
    if not timeout then timeout = defaultTimeout end
    if type(asset) == 'table' then
      for i, v in ipairs(asset) do
        if not lib.request.ptfxAsset(v, timeout) then
          return false
        end
      end
      return true
    end

    local start_time = GetGameTimer()
    while not HasNamedPtfxAssetLoaded(asset) do
      RequestNamedPtfxAsset(asset)
      if GetGameTimer() - start_time > timeout then
        return false
      end
      Wait(0)
    end
    return true
  end,

  streamedTextureDict = function(txd, timeout)
    assert(txd, 'a streamed texture dict is required')
    assert(type(txd) == 'string' or type(txd) == 'table', 'txd must be a string or table')
    if not timeout then timeout = defaultTimeout end
    if type(txd) == 'table' then
      for i, v in ipairs(txd) do
        if not lib.request.streamedTextureDict(v, timeout) then
          return false
        end
      end
      return true
    end

    local start_time = GetGameTimer()
    while not HasStreamedTextureDictLoaded(txd) do
      RequestStreamedTextureDict(txd)
      if GetGameTimer() - start_time > timeout then
        return false
      end
      Wait(0)
    end

    return true
  end,

  audioBank = function(bank, timeout)
    assert(bank, 'an audio bank is required')
    assert(type(bank) == 'string' or type(bank) == 'table', 'bank must be a string or table')
    if not timeout then timeout = defaultTimeout end
    if type(bank) == 'table' then
      for i, v in ipairs(bank) do
        if not lib.request.audioBank(v, timeout) then
          return false
        end
      end
      return true
    end

    local start_time = GetGameTimer()
    while not RequestScriptAudioBank(bank, false) do
      if GetGameTimer() - start_time > timeout then
        return false
      end
      Wait(0)
    end

    return true
  end,

  animDict = function(dict, timeout)
    assert(dict, 'an anim dict is required')
    assert(type(dict) == 'string' or type(dict) == 'table', 'dict must be a string or table')
    if not timeout then timeout = defaultTimeout end
    if type(dict) == 'table' then
      for i, v in ipairs(dict) do
        if not lib.request.animDict(v, timeout) then
          return false
        end
      end
      return true
    end

    local start_time = GetGameTimer()
    while not HasAnimDictLoaded(dict) do
      RequestAnimDict(dict)
      if GetGameTimer() - start_time > timeout then
        return false
      end
      Wait(0)
    end

    return true
  end,
}


return lib.request





--\\ Useage


-- lib.requestModel('a', 1000) -- returns true or false
-- lib.requestModel({'a', 'b', 'c'}, 1000) -- returns true or false

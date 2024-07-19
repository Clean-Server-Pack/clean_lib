local defaultTimeout = 20000

lib.request = {
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
}


return lib.request



--\\ Useage


-- lib.requestModel('a', 1000) -- returns true or false
-- lib.requestModel({'a', 'b', 'c'}, 1000) -- returns true or false

-- OXLIB Compatibility Layer
lib.requestAnimDict = lib.request.animDict 
lib.requestModel    = lib.request.model


-- Points 

lib.points          = function(data)
  return lib.zones.register(data.id or nil, data)
end


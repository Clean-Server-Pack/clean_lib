lib.file = {
  load = function(path, from_central)
    local raw_data = LoadResourceFile(not from_central and GetCurrentResourceName() or 'dirk_lib/saved_data', path)
    if not raw_data then 
      return false 
    end 
    return json.decode(raw_data)
  end,
  
  save = function(path, data, from_central)
    local raw_data = json.encode(data, {indent = true})
    return SaveResourceFile(not from_central and GetCurrentResourceName() or 'dirk_lib/saved_data', path, raw_data)
  end,
}

return lib.file
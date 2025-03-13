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

  inDirectory = function(path, pattern)
    local resource = cache.resource

    if path:find('^@') then
      resource = path:gsub('^@(.-)/.+', '%1')
      path = path:sub(#resource + 3)
    end

    local files = {}
    local fileCount = 0
    local windows = string.match(os.getenv('OS') or '', 'Windows')
    local command = ('%s%s%s'):format(
      windows and 'dir "' or 'ls "',
      (GetResourcePath(resource):gsub('//', '/') .. '/' .. path):gsub('\\', '/'),
      windows and '/" /b' or '/"'
    )

    local dir = io.popen(command)

    if dir then
      for line in dir:lines() do
        if line:match(pattern) then
          fileCount += 1
          files[fileCount] = line
        end
      end

      dir:close()
    end

    return files, fileCount
  end

}

return lib.file
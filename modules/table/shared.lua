local valid_conversions = {
  'vectors',
  'items_sql',
  'string',
  'item_ox',
  'convert_indexes',
}


lib.table = {
  deepClone = deepClone,
  findKeyInTable = findKeyInTable,

  includes = function(table, value, recursive)
    for k,v in pairs(table) do
      if v == value then return true; end
      if type(v) == 'table' and recursive then
        if lib.table.includes(v, value, recursive) then return true; end
      end
    end
    return false
  end,

  convert = function(_type, data)
    assert(_type, "Type is required for table conversion")
    assert(data, "Data is required for table conversion")
    assert(lib.table.includes(valid_conversions, _type), "Invalid conversion type")

    if _type == "vectors" then
      return convert_to_vectors(data)
    elseif _type == 'items_sql' then 
      return convert_to_sql(data)
    elseif _type == 'string' then 
      return convert_to_string(data)
    elseif _type == 'item_ox' then 
      return convert_to_ox(data)
    elseif _type == 'convert_indexes' then
      return convert_indexes(data)
    end
  end, 

  count = function(table)
    local string_indexes = table[1] and true or false
    if not string_indexes then 
      return #table
    else 
      local count = 0
      for k,v in pairs(table) do
        count = count + 1
      end
      return count
    end 
  end,
}

convert_indexes = function(tbl, new_indexing)
  for k,v in pairs(tbl) do
    local new_index = new_indexing[k]
    if new_index then 
      tbl[new_index] = tbl[k]
      tbl[k] = nil
    end
  end
  return tbl
end



findKeyInTable = function(tbls, key)
  local findInTable = function(tbl, key)
    for _key, data in pairs(tbl) do
      if type(data) == 'table' then
        local found = findInTable(data, key)
        if found then return found; end
      else
        if _key == key then return data; end
      end
    end
    return false
  end

  for _, table in pairs(tbls) do
    for _key, data in pairs(table) do 
      if type(data) == 'table' then
        local found = findInTable(data, key)
        if found then return found; end
      else
        if _key == key then return data; end
      end      
    end
  end
  return false
end

deepClone = function(table)
  local cloned = {}
  for key, value in pairs(original) do
    if type(value) == "table" then
      cloned[key] = deepClone(value)  -- Recursive call for nested tables
    else
      cloned[key] = value  -- Copy non-table values directly
    end
  end
  return cloned
end

convert_to_ox = function(table)
  local ret = {}
  for item,data in pairs(table) do
    ret[item] = {} 
    assert(data.label, "Label is required for item "..item)
    assert(data.name, "Name is required for item "..item)
    assert(data.name == item, "Name and key must be the same for item "..item)
    assert(type(data.label) == "string", "Label must be a string for item "..item)
    
    for k,v in pairs(data) do 
      if k == "label" or k == "weight" or k == "stackable" then 
        if k ~= "stackable" then 
          ret[item][k] = v
        else
          ret[item]["stack"] = v
        end
      elseif k == 'image' then 
        ret[item].client = {
          image = v
        }
      end
    end
  end
  return ret
end

convert_to_string = function(table)
  local output = ""
  for k,v in pairs(table) do
    output = output.."['"..k.."']".." = {\n"
    for n,d in pairs(v) do
      if type(d) == "table" then
        output = output.."  ".."['"..n.."']".." = {\n"
          for i,m in pairs(d) do
            if type(m) == "boolean" then
              output = output.."    ".."['"..i.."']".." = "..tostring(m)..",\n"
            elseif type(m) == "number" then
              output = output.."    ".."['"..i.."']".." = "..m..",\n"
            else
              output = output.."    ".."['"..i.."']".." = '"..m.."',\n"
            end
          end
        output = output.."  },"
      elseif type(d) == "boolean" then
        output = output.."  ".."['"..n.."']".." = "..tostring(d)..","
      elseif type(d) == "number" then
        output = output.."  ".."['"..n.."']".." = "..d..","
      else
        output = output.."  ".."['"..n.."']".." = '"..d.."',"
      end
      output = output.."\n"
    end
    output = output.."\n},\n"
  end
  return output
end

convert_to_vectors = function(table)
  local formattedTable = {}
  for key, value in pairs(table) do
    if type(value) == "table" and not value.x then
      formattedTable[key] = convert_to_vectors(value) -- Recursively call the function for nested tables
    else
      if type(value) == "table" and value.x and value.y and value.z and value.w then
        formattedTable[key] = vector4(value.x, value.y, value.z, value.w)
      elseif type(value) == "table" and value.x and value.y and value.z then
        formattedTable[key] = vector3(value.x, value.y, value.z)
      elseif type(value) == "table" and value.x and value.y then
        formattedTable[key] = vector2(value.x, value.y)
      else
        formattedTable[key] = value
      end
    end
  end
  return formattedTable
end

convert_to_sql = function(table)
  local tableCount = lib.table.count(table)
  local output = "INSERT INTO `"..Config.ItemsDatabaseName.."` (`name`, `label`) VALUES"
  local currentNumber = 0
  for k,v in pairs(t) do
    assert(v.label, "Label is required for item "..k)
    assert(v.name, "Name is required for item "..k
    assert(v.name == k, "Name and key must be the same for item "..k)
    assert(type(v.label) == "string", "Label must be a string for item "..k))
    currentNumber = currentNumber + 1
    output = output..string.format("\n ('%s', '%s')%s", k, v.label, currentNumber == tableCount and "" or ",")
  end
  output = output..";"
  return output
end

return lib.table

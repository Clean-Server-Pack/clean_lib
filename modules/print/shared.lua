local print_types = {
  info = {
    prefix = '^5[INFO]^7',
    condition = function() return true end
  },
  warn = {
    prefix = '^3[WARN]^7',
    condition = function() return true end
  },
  error = {
    prefix = '^1[ERROR]^7',
    condition = function() return true end
  },
  debug = {
    prefix = '^2[DEBUG]^7',
    condition = function() return settings.debug end
  },
}


lib.addPrintType = function(_type, prefix, condition)
  print_types[_type] = {
    prefix = prefix,
    condition = condition
  }
end


local convert_to_string = function(...)
  local args = {...}
  local string = ''
  for i, v in ipairs(args) do 
    local type_v = type(v)
    print(type_v)
    if type_v == 'table' then 
      string = string .. '\n'..json.encode(v, {indent = true}).. '\n'
    elseif type_v == 'function' then
      string = string .. '\n'.. i..' = function()\n\nend\n'
    else
      string = string .. ' '.. tostring(v)
    end
  end
  return string
end

lib.print = function(_type, ...)
  local args = {...}
  if type(_type) == 'table' then 
    args = _type
    _type = 'info'
  end
  local print_type = print_types[_type]
  if not print_type then 
    print_type = print_types.info
  end

  local string = convert_to_string(...) 
  if print_type.condition() then 
    print(print_type.prefix, string)
  end
end

return lib.print
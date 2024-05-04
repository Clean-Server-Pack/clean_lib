local current_objects = {}

CreateThread(function()
  while true do 
    for k,v in pairs(current_objects) do 
      print('Object', k, v)
    end
    Wait(1000)
  end
end)


lib.objects = {
  register = function(name, object)
    current_objects[name] = object
  end,
}


return lib.objects
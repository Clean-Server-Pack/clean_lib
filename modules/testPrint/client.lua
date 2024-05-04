-- local cb_event  = ('__dirk_cb:%s')
-- local callbacks = {}


-- RegisterNetEvent(cb_event:format(cache.resource), function(key, ...)
--   local exists = callbacks[key]
--   if not exists then 
--     error(('Callback %s does not exist'):format(key))
--   end
--   return cb and cb(...) 
-- end)

-- local generate_cb_key = function()
--   local id = ('%s-%s'):format(GetGameTimer(), math.random(1000, 9999))
--   if callbacks[id] then 
--     Wait(0)
--     return generate_cb_key()
--   end
--   return id
-- end

-- lib.callback = function(name, cb, ...)
--   local key = generate_cb_key()
--   callbacks[key] = cb
--   TriggerServerEvent(cb_event:format(cache.resource), key, ...)
-- end



lib.testPrint = function(msg)
  print(msg)
end


return lib.testPrint